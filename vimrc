" Avoid using vim
set nocompatible

colorscheme default

" Bepo layout remap
source ~/.vimrc_bepo_remap


" Highlight search result
set hls

set autoindent
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
let g:CommandTWildIgnore=&wildignore . ",**/bower_components/*,**/node_modules/*,target,project/target"

set so=7

set incsearch " Search à la firefox (search while typing)


" Vala highlighting
let vala_comment_strings = 1

" Omni completion
imap <Nul> <C-x><C-o>
autocmd FileType html        set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css         set omnifunc=csscomplete#CompleteCSS
autocmd FileType javascript  set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType c           set omnifunc=ccomplete#Complete
autocmd FileType php         set omnifunc=phpcomplete#CompletePHP
autocmd FileType ruby        set omnifunc=rubycomplete#Complete
autocmd FileType sql         set omnifunc=sqlcomplete#Complete
autocmd FileType python      set omnifunc=pythoncomplete#Complete
autocmd FileType xml         set omnifunc=xmlcomplete#CompleteTags
set completeopt=menu,longest

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

" pathogen
call pathogen#infect()

" Remap the leader key
let mapleader=','

" neocomplcache configuration
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_fuzzy_completion = 1

let g:syntastic_python_checkers=['flake8']
let g:syntastic_enable_signs=0

let g:syntastic_cpp_compiler_options = ' -std=c++14'

set t_Co=256

let ropevim_vim_completion=1

highlight UnderCursor ctermbg=153
autocmd CursorMoved * exe printf('match UnderCursor /\V\<%s\>/', escape(expand('<cword>'), '/\'))

let g:CommandTAcceptSelectionSplitMap=['<C-g>']

" Remove trailing spaces
autocmd BufWritePre *.{py,c,cpp,ml,rb,hs} :%s/\s\+$//e

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
