set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
 set rtp+=~/.vim/bundle/Vundle.vim
 call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
 Plugin 'gmarik/Vundle.vim'
 "Plugin 'flazz/vim-colorschemes'
 Plugin 'mkitt/tabline.vim'
 Plugin 'vim-scripts/Conque-GDB'
 Plugin 'SirVer/ultisnips'
 Plugin 'honza/vim-snippets'
 Plugin 'altercation/vim-colors-solarized'
"
" " The following are examples of different formats supported.
" " Keep Plugin commands between vundle#begin/end.
" " plugin on GitHub repo
 "Plugin 'klen/python-mode'
 Plugin 'Valloric/YouCompleteMe'
 Plugin 'oplatek/Conque-Shell'
 Plugin 'amsword/comments.vim'
 "Plugin 'Shougo/neocomplcache.vim'

 Plugin 'tpope/vim-fugitive'
" " plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" " Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" " git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" " The sparkup vim script is in a subdirectory of this repo called vim.
" " Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" " Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}
"
" " All of your Plugins must be added before the following line
 call vundle#end()            " required
 filetype plugin indent on    " required


set wrap
set nocp
inoremap jk <ESC>
filetype plugin on
syntax on
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set tw=79
"set foldmethod=syntax
map <F2> :retab <CR> :wq! <CR>
let g:netrw_localrmdir="rm -r"
set nowrap
"set statusline+=%F
set laststatus=2
set tags+=~/.vim/tags/cpp
set tags+=./tags
set number
"let OmniCpp_NamespaceSearch = 1
"let OmniCpp_GlobalScopeSearch = 1
"let OmniCpp_ShowAccess = 1
"let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
"let OmniCpp_MayCompleteDot = 1 " autocomplete after .
"let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
"let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let g:neocomplcache_enable_at_startup = 1
"let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
"set completeopt=menuone,menu,longest,preview
nnoremap <silent> <Leader>df :call DiffToggle()<CR>

function! DiffToggle()
	if &diff
		diffoff
	else
		diffthis
	endif
:endfunction

set autoindent
set cindent
set hidden
set hlsearch 
augroup filetype
  au! BufRead,BufNewFile *.proto setfiletype proto
augroup end

map ,j :!ctags -R -I --c++-kinds=+p --fields=+iaS --extra=+q . <CR><CR>

nmap t% :tabedit %<CR>
nmap td :tabclose<CR>

"color ron 
syntax enable
set background=dark
colorscheme solarized
set modifiable
let mapleader=","
set backspace=indent,eol,start
let g:ConqueTerm_ReadUnfocused = 1
noremap <leader>m :MaximizerToggle<CR>

"Convert slashes to backslashes for Windows.
if has('win32')
nmap ,cs :let @*=substitute(expand("%"), "/", "\\", "g")<CR>
nmap ,cl :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>

" This will copy the path in 8.3 short format, for DOS and Windows 9x
nmap ,c8 :let @*=substitute(expand("%:p:8"), "/", "\\", "g")<CR>
else
nmap ,cs :let @*=expand("%")<CR>
nmap ,cl :let @*=expand("%:p")<CR>
endif



function! Tab_Or_Complete()
	if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
	return "\<C-N>"
	else
	return "\<Tab>"
	endif
	endfunction
	:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
	:set dictionary="/usr/dict/words"

nmap ,lcd :lcd %:p:h<CR>

"trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
"
let g:CommandTMaxFiles=50000
"if has("terminfo")
    "let &t_Co=16
    "let &t_AB="\<Esc>[%?%p1%{8}%<%t%p1%{40}%+%e%p1%{92}%+%;%dm"
    "let &t_AF="\<Esc>[%?%p1%{8}%<%t%p1%{30}%+%e%p1%{82}%+%;%dm"
"else
    "let &t_Co=16
    "let &t_Sf="\<Esc>[3%dm"
    "let &t_Sb="\<Esc>[4%dm"
"endif
if exists("+showtabline")
    set stal=2
    map    <C-Tab>    :tabnext<CR>
    imap   <C-Tab>    <C-O>:tabnext<CR>
    map    <C-S-Tab>  :tabprev<CR>
    imap   <C-S-Tab>  <C-O>:tabprev<CR>
endif

let g:ConqueGdb_Leader = '\'
let g:pymode_warnings = 1
