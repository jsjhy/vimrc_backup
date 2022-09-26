set nocompatible              " be iMproved, required
set nu rnu
set history=100        " keep 50 lines of command line history
set ruler        " show the cursor position all the time
set showcmd        " display incomplete commands
set incsearch        " do incremental searching
set hlsearch        " do incremental searching
" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif
" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else
  set autoindent        " always set autoindenting on

endif " has("autocmd")


"------------
call plug#begin()
	Plug 'scrooloose/nerdtree'
	Plug 'gitgutter/Vim'
	"Plug 'junegunn/fzf.vim'
	"Plug 'vim-airline/vim-airline'
	"Plug 'vim-airline/vim-airline-themes'
	Plug 'tpope/vim-commentary'
	Plug 'itchyny/lightline.vim'
call plug#end()
"-------------
"lightline
set laststatus =2

" Set to auto read when a file is changed from the outside
set autoread

" Set mapleader
let mapleader = " "
let maplocalleader = ","

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Turn backup off,since most stuff is in SVN,git et.c anyway...
set nobackup
set nowb
set noswapfile

" auto change working dir
autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif

" ctrl c and v to clipboard
vmap <C-c> "+y
nmap <C-a> ggVG
nmap <C-v> "+p

" set nerdtree mapping
" map <F3> :NERDTreeMirror<cr>
let g:NERDTreeShowLineNumbers=1
map <F3> :NERDTreeToggle<cr>
"map <F4> :NERDTreeToggle<cr>:NERDTreeCWD<cr>

" show history list
nmap <leader>lh :bro ol<cr>
nmap bu :<C-U>execute 'buffer ' . v:count<CR>
nmap bn :bn<cr>
nmap bp :bp<cr>
nmap <leader>lb :ls<cr>

" set fdm=indent
set autowrite
set ignorecase smartcase

" map tab
nmap tn :tabn<cr>
nmap tp :tabp<cr>

set encoding=utf-8 fileencodings=ucs-bom,utf-8,cp936

" set customize highlight color
hi CursorLine ctermbg=240 ctermfg=230

" Locate and return character "above" current cursor position.
function! LookUpwards()
    let column_num = virtcol('.')
    let target_pattern = '\%' . column_num . 'v.'
    let target_line_num = search(target_pattern . '*\S', 'bnW')

    if !target_line_num
        return ""
    else
        return matchstr(getline(target_line_num), target_pattern)
    endif
endfunction

imap <silent> <C-Y> <C-R><C-R>=LookUpwards()<CR>
noremap <leader><CR> :nohlsearch<CR>

nmap <leader>fg :!grep -rn <C-R><C-R>=expand("<cword>")<CR>

map <F5> :bel term<CR>

" Do not show the message at launching nothing
set shortmess=atI

tnoremap <F1> <C-W>N

" Add coordination line
" set bg=dark
set cursorline
"set cursorcolumn
"set colorcolumn=81

" See [http://vim.wikia.com/wiki/Highlight_unwanted_spaces]
" - highlight trailing whitespace in red
" - have this highlighting not appear whilst you are typing in insert mode
" - have the highlighting of whitespace apply when you open new buffers
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches() " for performance

" colorschema
set background=dark

