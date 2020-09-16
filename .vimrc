" -*- vim -*-
"          File: .vimrc
"###################################################
"#   dhhong's personal Vim settings.
"#--------------------------------------------------
"# arthor : Seung Seop Park
"# editor : Doo Hwa Hong (dhhong@hi.snu.ac.kr)
"# Human Interface Lab, SNU / Feb 2009
"###################################################

"set fileencodings=euc-kr,utf-8
set fileencodings=utf-8
set termencoding=utf-8
set encoding=cp949
set tabstop=4
set shiftwidth=4 
set smarttab
syntax on
set number
set ai
set smartindent
set wrap
set ruler
set incsearch
set nocompatible
set splitbelow
set splitright
colorscheme evening
:filetype on
set cindent
set statusline=[%02n]\ %f\ %(\[%M%R%H]%)%=\ %4l,%02c%2V\ %P%*
set laststatus=2 " Always display a status line at the bottom of window.
set bs=2 		 " Allow backspacing over everything in insert mode.

" make backup files
set backup
set backupdir=~/.vim/backup,.,/tmp
set directory=.,~/.vim/backup,/tmp " where to write swap files?

set hlsearch 	" highlight search string

" Command-Line Completion : try ':help getwinpos<Tab>'
set wildmode=list:longest,full
set wildignore=*.o,*.pyc,*.bak

"set mouse=a

" assume /g for all substituions
"set gdefault

" set tag files.
"if has("Win32")
"  set tags=./tags,../tags,q:/Develop/Src/tags,q:/Products/Src/tags,q:/Products/Java/tags
"else
set tags=./tags,../tags,../../tags/,../../../../tags
"endif

" set list
set listchars=eol:$,tab:>-,trail:-,extends:>,precedes:<
"set list!

if has("gui")
  " set the gui options to:
  "   g: grey inactive menu items
  "   m: display menu bar
  "   r: display scrollbar on right side of window
  "   b: display scrollbar at bottom of window
  "   t: enable tearoff menus on Win32
  "   T: enable toolbar on Win32
  set go=gmrb
endif


" when split window, use opened window if the file is already opened
set switchbuf=useopen

" keep the contents of old buffers when switching to another file
set hidden

" backspace can delete also
set backspace=indent,eol,start

" wrap over lines
set whichwrap=h,l,~,[,]

" ************************************************************
" PlugIns

"-- For minibuf explorer
"let g:miniBufExplVSplit = 20   " enable vertical mode and specify column width in chars
let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplMapWindowNavArrows = 1
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplModSelTarget = 1
"let g:miniBufExplSplitBelow = 1

" ************************************************************
" C O M M A N D S
"
command! CD cd %:p:h

" ************************************************************
" K E Y   M A P P I N G S
"
let mapleader = ","   " use , instead of \ 


imap <S-space> <esc> 
set winaltkeys=no
nmap <M-Space> :simalt ~<CR>
"nmap : q:i
"nmap / q/i
"nmap ? q?i
map <F11> <ESC>:w <CR>
map <F12> <ESC>:q <CR>
imap <F11> <ESC>:w <CR>
imap <F12> <ESC>:q <CR>
map <F5> <ESC>:e <CR>

" shortcut to navigate windows
"map <C-J> <C-W>j<C-W>_
"map <C-K> <C-W>k<C-W>_
"map <C-H> <C-W>h
"map <C-L> <C-W>l
set wmh=0 " set the minimum window height to 0
set wmw=0
" multiple file navigation
map <C-N> <ESC>:bn <CR>
map <C-P> <ESC>:bp <CR>
" trim spaces at the end of lines
"map <C-T> <ESC>:%s/\s*$//

" horizon windows <-> vertical windows
map <F8> <ESC>:MiniBufExplorer <CR> :windo wincmd K <CR> 
map <F9> <ESC>:CMiniBufExplorer <CR> :windo wincmd H <CR> 

" map space, backspace to pagedown, pageup
noremap <Space> <PageDown>
noremap <BS> <PageUp>

" Make tab in v mode work like I think it should (keep highlighting):
"vmap <tab> >gv
"vmap <s-tab> <gv
" shifting blocks visually
vnoremap < <gv
vnoremap > >gv

" make it easy to update/reload .vimrc
:nmap ,s :source ~/.vimrc
:nmap ,v :e      ~/.vimrc


" easy edit files in the same directory as the current file
if has('unix')
    map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
else
    map ,e :e <C-R>=expand("%:p:h") . "\\" <CR>
endif

" use keypad number
if &term=="xterm" || &term=="xterm-color"
	imap <ESC>Oq 1
	imap <ESC>Or 2
	imap <ESC>Os 3
	imap <ESC>Ot 4
	imap <ESC>Ou 5
	imap <ESC>Ov 6
	imap <ESC>Ow 7
	imap <ESC>Ox 8
	imap <ESC>Oy 9
	imap <ESC>Op 0
	imap <ESC>On .
	imap <ESC>OQ /
	imap <ESC>OR *
	imap <ESC>Ol +
	imap <ESC>OS -
	nmap <ESC>Oq 1
	nmap <ESC>Or 2
	nmap <ESC>Os 3
	nmap <ESC>Ot 4
	nmap <ESC>Ou 5
	nmap <ESC>Ov 6
	nmap <ESC>Ow 7
	nmap <ESC>Ox 8
	nmap <ESC>Oy 9
	nmap <ESC>Op 0
	nmap <ESC>On .
	nmap <ESC>OQ /
	nmap <ESC>OR *
	nmap <ESC>Ol +
	nmap <ESC>OS -
	vmap <ESC>Oq 1
	vmap <ESC>Or 2
	vmap <ESC>Os 3
	vmap <ESC>Ot 4
	vmap <ESC>Ou 5
	vmap <ESC>Ov 6
	vmap <ESC>Ow 7
	vmap <ESC>Ox 8
	vmap <ESC>Oy 9
	vmap <ESC>Op 0
	vmap <ESC>On .
	vmap <ESC>OQ /
	vmap <ESC>OR *
	vmap <ESC>Ol +
	vmap <ESC>OS -
endif

" ************************************************************
" A B B R E V I A T I O N
"
ab #b /*******************************************************************
ab #e <space>******************************************************************/

ab #i #include
" useful command
" :sba       -> split all buffer
" :vert sba

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File Explorer
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:explVertical=1 " should I split verticially
"let g:explWinSize=25 " width of 35 pixels
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Win Manager
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:winManagerWidth=25 " How wide should it be( pixels)
"let g:winManagerWindowLayout = 'FileExplorer,TagsExplorer|BufExplorer' " What windows should it


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CMake support
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
":autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in runtime! indent/cmake-indent.vim 
:autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in runtime! indent/cmake.vim 
:autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in setf cmake
:autocmd BufRead,BufNewFile *.ctest,*.ctest.in setf cmake

