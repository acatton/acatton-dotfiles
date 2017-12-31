""" Copyright (C) 2017 Antoine Catton <devel@antoine.catton.fr>
"""
""" This program is free software. It comes without any warranty, to
""" the extent permitted by applicable law. You can redistribute it
""" and/or modify it under the terms of the Do What The Fuck You Want
""" To Public License, Version 2, as published by Sam Hocevar. See
""" the LICENSE file for more details.

" Avoid double loading
if exists('g:vaguely_fzf_loaded')
  finish
endif

let g:vaguely_fzf_loaded = 1

let g:vaguely_fzf_executable = get(g:, 'vaguely_fzf_executable', 'fzf')

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
  elseif a:single_arg =~ '^\w+$'
    return a:single_arg
  else
    return "'" . substitute(a:single_arg, "'", "'\"'\"'", 'g') . "'"
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

" Execute any executable with its arguments escaped.
" For example:
"   s:execute('ls', ['-l', 'some file'])
" will run the shell command:
"   ls -l 'some file'
" You could consider that as the equivalent of: man 3 execv
function! s:execute(executable, args)
  execute 'silent !' . s:escape_single_arg(a:executable) . ' ' . s:escape_args(a:args)
  redraw!
endfunction

" Simplest function ever: just invoke the fzf binary with some arguments
" passed as a list.
function! s:fzf(fzf_args) abort
  if !exists('s:executable')
    if executable(g:vaguely_fzf_executable)
      let s:executable = g:vaguely_fzf_executable
    else
      call s:error('Could not find executable ' . g:vaguely_fzf_executable)
      return
    endif
  endif
  return s:execute(s:executable, a:fzf_args)
endfunction


" Wraps s:fzf in order to be compatible with a defined
" command.
function! s:fzf_wrapper(...) abort
  return s:fzf(a:000)
endfunction

command! -nargs=* VaguelyFZF call s:fzf_wrapper(<args>)

" vim: et:ts=2:sts=2:sw=2
