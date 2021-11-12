set path+=**
set title                   " Set terminal title
set showmatch
set rnu                     " Relative number lines
set ignorecase
set mouse=a
set hlsearch
set incsearch
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set autoindent
set smarttab
set number                  " Show line numbers
set wildmode=longest,list
filetype plugin indent on   " Required for plugins
syntax on
set clipboard=unnamedplus   " Copy from os and vice versa
set noshowmode              " Hide status, since airline already shows
let mapleader = " "         " Use space as leader

" vs = right, hs = bottom
set splitbelow splitright

" Automatically go into insert when entering a vim terminal, change back to
" normal when leaving
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert
" Use escape to go back to normal mode while in terminal mode
tnoremap <Esc> <C-\><C-n>

call plug#begin('~/.vim/plugged')
"{{ Theming }}
    Plug 'morhetz/gruvbox'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'Pocco81/TrueZen.nvim'

"{{ File management }}
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'mhinz/vim-startify'
    Plug 'ryanoasis/vim-devicons'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

"{{ Tim Pope }}
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'

"{{ Syntax }}
    Plug 'cespare/vim-toml', { 'branch': 'main' }
    Plug 'dag/vim-fish'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'frazrepo/vim-rainbow'
    Plug 'honza/vim-snippets'
    Plug 'ARM9/arm-syntax-vim'
    Plug 'dkarter/bullets.vim'
    Plug 'plasticboy/vim-markdown'
    Plug 'godlygeek/tabular'
    Plug 'fladson/vim-kitty'
    Plug 'jackguo380/vim-lsp-cxx-highlight'

"{{ Other }}
    " Plug 'kana/vim-submode'

call plug#end()
" call window_submode#WindowSubmodeKeybinds()
" color schemes
if (has("termguicolors"))
 set termguicolors
endif
syntax enable
colorscheme gruvbox

augroup Chad
    autocmd!
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'CHADopen' | wincmd p | ene | exe 'cd '.argv()[0] | endif
augroup END

" Enable latex in markdown
let g:vim_markdown_math = 1
" Disable folding in markdown
let g:vim_markdown_folding_disabled = 1

" Enable vim-rainbow globally
let g:rainbow_active = 1

" Arm support
au BufNewFile,BufRead *.s,*.S set filetype=arm " arm = armv6/7

" Airling theme
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1
    " Disable airline trailing whitespace warning
autocmd VimEnter * silent AirlineToggleWhitespace

" Make tabs persist
inoremap <Return> <Return><Space><BS>
inoremap {<CR> {<CR>} <Esc>ko<Space><BS>
nnoremap o o<Space><BS>
nnoremap O O<Space><BS>

" Move through wrapped text naturally
nnoremap j gj
nnoremap k gk

noremap K {
noremap J }
noremap H ^
noremap L $

" CHADTree bindings
nnoremap <C-\> <cmd>CHADopen<CR>
    " Allow moving cwd up a directory in CHADTree
autocmd FileType CHADTree nmap <silent> <buffer> B :cd ..<cr>
    " Close chadtree if it is the last window open
autocmd BufEnter * if (winnr("$") == 1 && &filetype == "CHADTree") | q | endif

" ',' repeats last macro
nnoremap , @@

" cib, dib, etc. don't do anything, rebind to ciB, ...
nnoremap cib ciB
nnoremap dib diB
nnoremap vib viB

" Tab and S-Tab control indentation in normal mode
nnoremap <Tab> >>
nnoremap <S-Tab> <<
vnoremap <Tab> >
vnoremap <S-Tab> <

" Telescope bindings
" noremap <C-p> :Telescope find_files <CR>
" noremap <C-f> :Telescope treesitter<CR>

" Movement keys while in insert mode
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" Move line up or down with Alt+(k/j)
nnoremap <M-k> :m -2<cr>
nnoremap <M-j> :m +1<cr>
inoremap <M-k> <right><ESC>:m -2<cr>i
inoremap <M-j> <right><ESC>:m +1<cr>i

" Coc bindings
nmap <leader>rn <Plug>(coc-rename)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> <leader>jy <Plug>(coc-type-definition)
nmap <silent> <leader>ji <Plug>(coc-implementation)
nmap <silent> <leader>jr <Plug>(coc-references)

" Fugitive bindings
nmap <silent> <leader>gd :Gdiffsplit<cr>
nmap <silent> <leader>gb :GBrowse<cr>
nmap <silent> <leader>gc :Git commit<cr> 
nmap <silent> <leader>ga :Git add .<cr>
nmap <silent> <leader>gp :Git push<cr>

" Zen mode bindings
nmap <silent> <leader>zm :TZMinimalist<cr>
nmap <silent> <leader>zf :TZFocus<cr>
nmap <silent> <leader>zn :TZAtaraxis<cr> :AirlineRefresh<cr>

" Launch markdown preview binding
nmap <leader>md <Plug>MarkdownPreviewToggle

" Remove vim bg, so kitty bg image will show
hi Normal guibg=none ctermbg=none

