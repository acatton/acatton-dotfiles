""" Copyright (C) 2017 Antoine Catton <devel@antoine.catton.fr>
"""
""" This program is free software. It comes without any warranty, to
""" the extent permitted by applicable law. You can redistribute it
""" and/or modify it under the terms of the Do What The Fuck You Want
""" To Public License, Version 2, as published by Sam Hocevar. See
""" the LICENSE file for more details.


" Avoid double loading
if exists('g:vaguely_loaded')
  finish
endif

let g:vaguely_loaded = 1

let g:vaguely_fzf_executable = get(g:, 'vaguely_fzf_executable', 'fzf')

" List of openning shortcuts
let g:vaguely_openers = get(g:, 'vaguely_openers',
\   {
\       '': 'edit',
\       'ctrl-t': 'new tab',
\       'ctrl-v': 'vertical split',
\       'ctrl-x': 'horizontal split',
\   })

let g:vaguely_colorspec = get(g:, 'vaguely_colorspec', 'bw')

let s:opener_to_command = {'edit': 'e', 'new tab': 'tabnew',
\                          'vertical split': 'vsplit', 'horizontal split': 'split'}

" This is horrible... This is because vim doesn't have closures and lambda
" functions. We maintain the state of all jobs inside this variable, and we
" clean it up every time we access.
let s:job_state = {}


" Shamelessly copy/pasted from the original fzf.vim
" <https://github.com/junegunn/fzf/blob/93aeae198511af76dc5b311601266bcaef36ba80/plugin/fzf.vim#L175-L179>
function! s:error(msg)
  echohl ErrorMsg
  echom a:msg
  echohl None
endfunction


" Shamelessly copy/pasted from the original fzf.vim
" <https://github.com/junegunn/fzf/blob/93aeae198511af76dc5b311601266bcaef36ba80/plugin/fzf.vim#L181-L185>
function! s:warn(msg)
  echohl WarningMsg
  echom a:msg
  echohl None
endfunction


" Shamelessly stolen from Python 3's shlex.quote()
function! s:escape_single_arg(single_arg)
  if a:single_arg =~ '^$'
    return "''"
  elseif a:single_arg =~ '^\w\+$'
    return a:single_arg
  else
    return "'" . substitute(a:single_arg, "'", '''"''"''', 'g') . "'"
  endif
endfunction


" Escape a list of argument for shell execution.
" This function protects against shell injection.
"
" For example:
"   ['foo', 'bar baz', '$qux']
" Will become:
"   foo 'bar baz' '$qux'
function! s:escape_args(many_args)
  return join(map(a:many_args, 's:escape_single_arg(v:val)'))
endfunction


function! s:escape_vim(str)
  let result = substitute(a:str, '[%#]', '\\&', 'g')
  return result
endfunction


function! s:execv(executable, args)
  let cmd = s:escape_args([a:executable] + [a:args])
  execute 'silent !' . s:escape_vim(cmd)
  redraw!
endfunction


function! s:term_execv(executable, args, io)
  let options = {'curwin': 1}

  if has_key(a:io, 'stdout')
    let options.out_io = 'file'
    let options.out_name = a:io.stdout
  endif

  if has_key(a:io, 'close_cb')
    let options.exit_cb = a:io.close_cb
  endif

  let cmd =  s:escape_args([a:executable] + a:args)
  let jobid = term_start([&shell, &shellcmdflag, cmd], options)
  call term_wait(jobid, 20)
  return jobid
endfunction


" Simplest function ever: just invoke the fzf binary with some arguments
" passed as a list.
function! vaguely#fzf(fzf_args, io) abort
  if !exists('s:executable')
    if executable(g:vaguely_fzf_executable)
      let s:executable = g:vaguely_fzf_executable
    else
      call s:error('Could not find executable ' . g:vaguely_fzf_executable)
      return
    endif
  endif

  return s:term_execv(s:executable, a:fzf_args, a:io)
endfunction


" Generate fzf command line arguments according to configuration
function! s:command_args()
    let arguments = []

    call add(arguments, '--expect=' . join(keys(g:vaguely_openers), ','))
    call add(arguments, '--color=' . g:vaguely_colorspec)

    return arguments
endfunction


function! s:open_files(method, filenames)
  let method_name = get(g:vaguely_openers, a:method, 'unknown')
  let escaped_filenames = map(a:filenames, 's:escape_vim(v:val)')

  if !has_key(s:opener_to_command, method_name)
    throw 'Can''t find opening method. There might be a bug somewhere, or bad config.'
  endif

  let cmd = s:opener_to_command[method_name]
  for fname in escaped_filenames
    execute ':' . cmd . ' ' . fname
  endfor
endfunction


function vaguely#files_cb_close(closure, jobid, status)
  execute 'keepalt b' . a:closure.buffer
  let fname = a:closure.stdout
  let lines = filereadable(fname) ? readfile(fname) : []
  if len(lines) > 1
    let method = lines[0]
    let filenames = lines[1:]
    call s:open_files(method, filenames)
  endif
endfunction


function vaguely#files()
    let arguments = copy(s:command_args())

    let tmpfile = tempname()
    let closure = {'stdout': tmpfile, 'tmpfiles': [tmpfile], 'buffer': bufnr('')}

    let options = {
    \ 'stdout': tmpfile,
    \ 'close_cb': function('vaguely#files_cb_close', [closure]),
    \}
    let jobid = vaguely#fzf(arguments, options)
endfunction


nnoremap <silent> <plug>VaguelyFiles :call vaguely#files()<CR>


" vim: et:ts=2:sts=2:sw=2
