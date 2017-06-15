set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'vim-scripts/Conque-GDB'
Plugin 'altercation/vim-colors-solarized'
Plugin 'amsword/YouCompleteMe'
Plugin 'rdnetto/YCM-Generator'
Plugin 'oplatek/Conque-Shell'
Plugin 'amsword/comments.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'mkitt/tabline.vim'
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
let g:neocomplcache_enable_at_startup = 1
nnoremap <silent> <Leader>df :call DiffToggle()<CR>

function! DiffToggle()
	if &diff
		diffoff
	else
		diffthis
	endif
:endfunction

if executable('ag')
    " Note we extract the column as well as the file and line number
    set grepprg=ag\ --nogroup\ --nocolor\ --column
    set grepformat=%f:%l:%c%m
endif

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

let g:CommandTMaxFiles=50000

let g:ConqueGdb_Leader = '\'
let g:pymode_warnings = 1
set wrap
