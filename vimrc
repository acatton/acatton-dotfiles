" Avoid using vim
set nocompatible

colorscheme default
" Lightline
set noshowmode

" Bepo layout remap
source ~/.vimrc_bepo_remap

" Highlight search result
set hls

set smartindent
set tabstop=4 softtabstop=4 shiftwidth=4
set expandtab

set nobackup
set undodir=~/.vim-swp/undo
set undolevels=1000 undoreload=10000
set undofile
set directory=~/.vim-swp/swap/

set listchars=eol:¶,nbsp:%,tab:»\ 
set list " Display invisiable characters (tabs, unbreakable space and end of line)

set foldmethod=marker

" Highlight current line
set cursorline
hi  CursorLine term=NONE cterm=NONE ctermbg=7

set showcmd
set laststatus=2
set wildmode=list:longest,full " file completion à la ZSH
set wildmenu
set wildignore=*.pyc,*.pyo,*.o

set so=7

set incsearch " Search à la firefox (search while typing)
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)


" Vala highlighting
let vala_comment_strings = 1


" special highlights
let python_highlight_all=1 " Highlight everyting in python (especially trailing spaces)
let php_sql_query=1        " Parse and highlight SQL query in strings in PHP
let php_htmlInStrings=1    " Parse and highlight HTML in strings in PHP
let g:tex_flavor = "latex" " Default tex is latex

filetype on        " enables filetype detection
filetype plugin on " enables filetype specific plugins
filetype plugin indent on

" If you forgot to do sudoedit or sudo vi
command SudoW !sudo tee % > /dev/null

" Remap the leader key
let mapleader=','

set t_Co=256

highlight UnderCursor ctermbg=153
autocmd CursorMoved * exe printf('match UnderCursor /\V\<%s\>/', escape(expand('<cword>'), '/\'))

" Remove trailing spaces
autocmd BufWritePre *.{py,c,cpp,ml,rb,hs,go} :%s/\s\+$//e

" Lightline
let g:lightline = {
\   'colorscheme': 'one',
\   'active': {
\       'left': [ [ 'mode', 'paste' ], [ 'charvaluehex', 'readonly', 'modified', 'filename' ] ],
\       'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype' ] ],
\   },
\   'component': {
\       'charvaluehex': '0x%04B',
\   },
\   'component_function': {
\       'filename': 'LightlineFullFilename',
\   }
\}

function! LightlineFullFilename()
    let filename = expand('%')
    return filename !=# '' ? filename : '[No Name]'
endfunction

" FZF
let $FZF_DEFAULT_COMMAND = 'rg --files'
let g:fzf_files_options = ['--preview=head -c 512 {}', '--preview-window=right:30%']
"noremap <silent> <C-T> :call fzf#run(fzf#wrap('command-t', {'options': '--color=bw'}))<CR>
noremap <C-T> :Files<CR>
nnoremap <leader>d :LspDefinition<CR>

set completeopt-=preview
set completeopt+=menuone,noselect

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'whitelist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'whitelist': ['*'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ 'config': {'max_buffer_size': 5000000},
    \ 'priority': 10,
    \ }))

au User lsp_setup call lsp#register_server({
    \ 'name': 'pyls',
    \ 'cmd': ['_vim_asyncomplete_pyls'],
    \ 'whitelist': ['python'],
    \ })

au User lsp_setup call lsp#register_server({
    \ 'name': 'go-langserver',
    \ 'cmd': ['/home/antoine/Development/work/go/bin/go-langserver', '-gocodecompletion', '-format-tool', 'gofmt'],
    \ 'whitelist': ['go'],
    \ })

let g:lsp_signs_enabled = 0
let g:lsp_diagnostics_echo_cursor = 1
