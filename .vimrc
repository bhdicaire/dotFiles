set secure
let mapleader = ","
let maplocalleader = ";"
set autoindent
set backspace=indent,eol,start
set binary
set complete-=i
set encoding=utf-8 nobomb
set foldlevel=1
set gdefault
set guioptions=a            " hide scrollbars/menu/tabs
set laststatus=2
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list
set nocompatible
set noeol
set nospell
set nowrap
set nrformats-=octal
set number
set ruler
set showmode showcmd ttyfast
set smarttab
set visualbell noerrorbells
set wildmenu

if has('syntax') && !exists('g:syntax_on')
	syntax enable
 endif

" Centralize backups, swapfiles and undo history
if exists("&backupdir")
	set backupdir=~/.vim/
endif
if exists("&directory")
	set directory=~/.vim/swaps
endif
if exists("&undodir")
	set undodir=~/.vim/undo
endif
set backupskip=/tmp/*,/private/tmp/*  " Don’t create backups in specific directories

if !has('nvim') && &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=100
endif

set incsearch
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif

if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

set autoread

if &history < 1000
  set history=1000
endif
if &tabpagemax < 50
  set tabpagemax=50
endif
if !empty(&viminfo)
  set viminfo^=!
endif
if &sessionoptions =~# '\<options\>'
  set sessionoptions-=options
  set sessionoptions+=localoptions
endif

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=16
endif

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

noremap <C-U> <C-G>u<C-U>
" vim:set ft=vim et sw=2:

if has('gui_win64')
  set noantialias
  set guifont=Terminus:h12
  set lines=85
  nmap <silent> <leader>ev :e $HOME/_vimrc<CR>
  "overwrite mapping to reload the .vimrc"
  nmap <silent> <leader>rv :source $HOME/_vimrc<CR>
endif
if has('gui_win32')
  set noantialias
  set guifont=Terminus:h12
  set lines=85
  "overwrite mapping to edit the .vimrc"
  nmap <silent> <leader>ev :e $HOME/_vimrc<CR>
  "overwrite mapping to reload the .vimrc"
  nmap <silent> <leader>rv :source $HOME/_vimrc<CR>
endif
if has("gui_macvim")
  set fuopt=maxvert
  set noantialias
  set guifont=Terminus\ (TTF):h14
  "set guifont=Hack:h14
  command! ToggleFullScreen if &fu|set noantialias|set gfn=Terminus\ (TTF):h14|set co=80|set nofu|else|set antialias|set gfn=Inconsolata:h22|set co=100|set fu|endif
  an <silent> Window.Toggle\ Full\ Screen\ Mode :ToggleFullScreen<CR>
endif
