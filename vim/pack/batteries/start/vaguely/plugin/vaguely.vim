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

let g:vaguely_height = get(g:, 'vaguely_height', '50%')


let s:opener_to_command = {'edit': 'e', 'new tab': 'tabnew',
\                          'vertical split': 'vsplit', 'horizontal split': 'split'}


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


" Execute any executable with its arguments escaped.
" For example:
"   s:execv('ls', ['-l', 'some file'], {})
" will run the shell command:
"   ls -l 'some file'
" You could consider that as the equivalent of: man 3 execv
" The last parameter allows to specify an output, for example:
"   s:execv('ls', ['-l', 'some file'], {'stdout': '/dev/null'})
function! s:execv(executable, args, io)
  let cmd =  s:escape_single_arg(a:executable) . ' ' . s:escape_args(a:args)

  if has_key(a:io, 'stdout')
    let cmd = cmd . ' > ' . s:escape_single_arg(a:io.stdout)
  endif

  if has_key(a:io, 'stderr')
    let cmd = cmd . ' 2> ' . s:escape_single_arg(a:io.stderr)
  endif

  if has_key(a:io, 'stdin')
    let cmd = cmd . ' < ' . s:escape_single_arg(a:io.stdin)
  endif

  execute 'silent !' . s:escape_vim(cmd)
endfunction


" Wraps execv and returns the output of the command.
function! s:execute(executable, args, io)
  if has_key(a:io, 'stdout')
    throw 'execute() already captures stdout'
  endif

  let tmp = tempname()
  try
    let realio = copy(a:io)
    let realio.stdout = tmp

    call s:execv(a:executable, a:args, realio)

    return filereadable(tmp) ? readfile(tmp) : []
  finally
    call delete(tmp)
  endtry
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

  let output = s:execute(s:executable, a:fzf_args, a:io)
  redraw!
  return output
endfunction


" Generate fzf command line arguments according to configuration
function! s:command_args()
    let arguments = []

    call add(arguments, '--expect=' . join(keys(g:vaguely_openers), ','))
    call add(arguments, '--color=' . g:vaguely_colorspec)
    call add(arguments, '--height=' . g:vaguely_height)

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


function vaguely#files()
    let arguments = copy(s:command_args())
    let to_open = vaguely#fzf(arguments, {})

    if len(to_open) < 2
      return
    else
      let method = to_open[0]
      let filenames = to_open[1:]
      call s:open_files(method, filenames)
    endif
endfunction


nnoremap <silent> <plug>VaguelyFiles :call vaguely#files()<CR>


" vim: et:ts=2:sts=2:sw=2
