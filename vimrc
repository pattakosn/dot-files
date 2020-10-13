set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-scripts/taglist.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tikhomirov/vim-glsl'
Plugin 'tpope/vim-fugitive'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'brookhong/cscope.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'vim-airline/vim-airline'
Plugin 'majutsushi/tagbar'
Plugin 'Raimondi/delimitMate'
"Plugin 'kien/ctrlp.vim'
" C11 standard help files! press K over a keyword to see doc
Plugin 'joereynolds/vim-c-manual'
" ispc syntax highlighting
Plugin 'jez/vim-ispc'
Plugin 'rust-lang/rust.vim'
Plugin 'fatih/vim-go'
Plugin 'rudrab/vimf90'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"let g:ycm_path_to_python_interpreter='/usr/bin/python'

" use indentation of previous line
set autoindent
" use intelligent indentation for C
set smartindent
" configure tabwidth and insert spaces instead of tabs
"set tabstop=2        " tab width is 4 spaces
"set shiftwidth=2     " indent also with 4 spaces
"set expandtab        " expand tabs to spaces
" wrap lines at 120 chars. 80 is somewaht antiquated with nowadays displays.
"set textwidth=120
" turn syntax highlighting on
syntax on
colorscheme 256-jungle
" turn line numbers on
set number
" highlight matching braces
set showmatch
"Highlight search resuls
set hlsearch
"Always display tab bar. comment it or set it to 0
set showtabline=2
"Notify me when I am passed column 120
set colorcolumn=140
highlight ColorColumn ctermbg=darkgray
"set foldmethod=indent
set foldmethod=syntax
set foldlevel=4
"set t_Co=256
" Add these to force vim to source folder specific .vimrc file parsing
set exrc
set secure

" view man pages inside vim using :Man or ctrl-K
runtime! ftplugin/man.vim

" Use ctrl-n to open/close NERDTree
map <C-n> :NERDTreeToggle<CR>
" Automatically close NERDTtree when no other buffer is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"Automatically open NERDTree when opening vim
"autocmd vimenter * NERDTree

" Use F8 to open tagbar display
nmap <F8> :TagbarToggle<CR>

" Use F7 to open tagbar display
nmap <F7> :Tlist<CR>
"Show Taglist window on the right side
let Tlist_Use_Right_Window = 1
"Close folds for inactive files
let Tlist_File_Fold_Auto_Close=1
" point taglist to ctags
"let Tlist_Ctags_Cmd='/usr/bin/ctags'

" Use F9 to set build dir to ../build
nmap <F9> :set makeprg=make\ -C\ ../build<CR>

if has('cscope')
  set cscopetag cscopeverbose

  if has('quickfix')
    set cscopequickfix=s-,c-,d-,i-,t-,e-
  endif

"  cnoreabbrev csa cs add
"  cnoreabbrev csf cs find
"  cnoreabbrev csk cs kill
"  cnoreabbrev csr cs reset
"  cnoreabbrev css cs show
"  cnoreabbrev csh cs help
  cnoreabbrev <expr> csa  ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs add'  : 'csa')
  cnoreabbrev <expr> csf  ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs find' : 'csf')
  cnoreabbrev <expr> csk  ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs kill' : 'csk')
  cnoreabbrev <expr> csr  ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs reset' : 'csr')
  cnoreabbrev <expr> css  ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs show' : 'css')
  cnoreabbrev <expr> csh  ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs help' : 'csh')

  command -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src
endif

"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
