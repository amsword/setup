call plug#begin('~/.vim/plugged')
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'neoclide/coc.nvim', {'branch': 'master'}
"Plug 'gcmt/taboo.vim'
Plug 'gmarik/Vundle.vim'
"Plug 'PhilRunninger/nerdtree-visual-selection'
"Plug 'preservim/nerdtree'
"Plug 'vim-scripts/Conque-GDB'
Plug 'altercation/vim-colors-solarized'
Plug 'amsword/YouCompleteMe'
Plug 'rdnetto/YCM-Generator', {'branch': 'stable'}
Plug 'oplatek/Conque-Shell'
Plug 'amsword/comments.vim'
Plug 'tpope/vim-fugitive'
Plug 'mkitt/tabline.vim'
Plug 'SirVer/ultisnips'
Plug 'amsword/vim-snippets'
Plug 'szw/vim-maximizer'
Plug 'vim-scripts/vim-auto-save'
Plug 'vim-scripts/BufOnly.vim'
Plug 'roxma/vim-tmux-clipboard'
Plug 'neomake/neomake'
Plug 'ctrlpvim/ctrlp.vim'
"Plug 'vim-scripts/Tagbar'
Plug 'ntpeters/vim-better-whitespace'
Plug 'vim-latex/vim-latex'
Plug 'machakann/vim-highlightedyank'
Plug 'Vimjas/vim-python-pep8-indent'
"Plug 'wincent/command-t'
call plug#end()


call neomake#configure#automake('nrwi', 500)

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
"set foldmethod=indent
map <F2> :retab <CR> :wq! <CR>
let g:netrw_localrmdir="rm -rf"
set nowrap
"set statusline+=%F
" 0: never shows the status bar
" 1: show only if there are more than 2 window
" 2: always show
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
set hidden
set hlsearch 
augroup filetype
  au! BufRead,BufNewFile *.proto setfiletype proto
augroup end

nmap t% :tabedit %<CR>
nmap td :tabclose<CR>

"color ron 
syntax enable
set background=dark
let mapleader=","
set backspace=indent,eol,start
let g:ConqueTerm_ReadUnfocused = 1
noremap <leader>m :MaximizerToggle<CR>
noremap <leader>l :TagbarToggle<CR>

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

let g:CommandTMaxFiles=500000
let g:CommandTWildIgnore=&wildignore . ",*.o" . ",*.pyc" . ",*.so" . ",*.png" .
            \ ",*.log" . ",*/output/*" . ",*.d" . ",*/models/*" .
            \ ",*/mask_output/*" .
            \ ",*/tmp_run/*" . ",*.jpg" . ",*/data/*" . ",*.jpg" .
            \ ",.git,assets,*.jpg,tmp_run,*.png,*/build/*,*.dll,*.pdb,*.pyc"

let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.hg$\|\.svn$\|tmp_run$\|output$\|assets$\|lib.linux-x86_64-3.5$\|lib.linux-x86_64-3.6$\|temp.linux-x86_64-3.5$\|temp.linux-x86_64-3.6$',
    \ 'file': '\v\.(o|pyc|exe|dll|lib|jpg|png|jpeg|caffemodel|predict)$' }

let g:ConqueGdb_Leader = '\'
let g:ConqueGdb_DeleteBreak = g:ConqueGdb_Leader . 'd'
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
nnoremap <leader>jd :YcmCompleter GoTo<CR>


let g:netrw_sizestyle= "h"
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>"

let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_in_insert_mode = 0  " do not save while in insert mode
let g:auto_save_silent = 1  " do not display the auto-save notification

" the following is enough. auto-save could spend lots of time if disk is not of
" high-speed I/O
"au FocusLost * :wa

"set foldmethod=syntax

autocmd FileType cuda set ft=c
let Tlist_Show_One_File = 1

let g:ycm_confirm_extra_conf=0
let g:ctags_statusline=1 

set autoread

set shortmess+=A

let g:neomake_python_enabled_makers = ['pyflakes']
" we use ycm to do the syntax checking and thus, disable the neomake 
let g:neomake_cpp_enabled_makers=[]
let g:neomake_c_enabled_makers=[]


set wildignore+=*/tmp/*,*.so,*.swp,*.zip

augroup my_neomake_signs
    au!
    autocmd ColorScheme *
        \ hi NeomakeErrorSign ctermfg=red |
        \ hi NeomakeWarningSign ctermfg=yellow
augroup END

let g:neomake_error_sign = {'text': '✖', 'texthl': 'NeomakeErrorSign'}
"let g:neomake_error_sign = {
    "\ 'text': 'E>',
    "\ 'texthl': 'NeomakeErrorSign',
    "\ }
let g:neomake_warning_sign = {
    \   'text': '⚠',
    \   'texthl': 'NeomakeWarningSign',
    \ }
"this should be after augroup my_neomake_signs, or that does not work
colorscheme solarized

nmap <Leader>b :CtrlPBuffer<CR>
let g:ycm_server_python_interpreter='/usr/bin/python'

let g:ctrlp_max_files=0

set autoread

autocmd FileType markdown setlocal fdm=indent
autocmd FileType text setlocal fdm=indent
autocmd FileType yaml setlocal fdm=indent


" the following are from the readme of coc
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes


function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

set cmdheight=1

""""""""
let g:taboo_tab_format=' %N:%f '

set nofixeol

"set modifiable
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=4000
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction

"nmap <leader>sp :call <SID>SynStack()<CR>
"function! <SID>SynStack()
  "if !exists("*synstack")
    "return
  "endif
  "echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
"endfunc
"
hi Important ctermbg=yellow ctermfg=black
hi Best ctermbg=blue ctermfg=black


function! MakeSession(overwrite)
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:filename = b:sessiondir . '/session.vim'
  if a:overwrite == 0 && !empty(glob(b:filename))
    return
  endif
  exe "mksession! " . b:filename
endfunction

function! LoadSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (filereadable(b:sessionfile))
    exe 'source ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction

" Adding automatons for when entering or leaving Vim
if(argc() == 0)
  au VimEnter * nested :call LoadSession()
  au VimLeave * :call MakeSession(1)
else
  au VimLeave * :call MakeSession(0)
endif

"autocmd BufRead,BufNewFile *. set filetype=foo
"autocmd FileType text match Important /\[ip\]/
"autocmd FileType text syn match Important /\[ip\]/
"syntax on

