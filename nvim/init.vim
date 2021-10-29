set path+=**
set rnu                     " Relative number lines
set showmatch
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
" set cc=80
filetype plugin indent on   " Required for plugins
syntax on
set clipboard=unnamedplus   " Copy from os and vice versa
set noshowmode              " Hide status, since airline already shows
" set cursorline!

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
    Plug 'dracula/vim'
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
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
    Plug 'nvim-telescope/telescope-fzy-native.nvim'
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
    Plug 'kyazdani42/nvim-tree.lua'

"{{ Tim Pope }}
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'

"{{ Syntax }}
    Plug 'cespare/vim-toml', { 'branch': 'main' }
    Plug 'dag/vim-fish'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'frazrepo/vim-rainbow'
    Plug 'honza/vim-snippets'
    Plug 'ARM9/arm-syntax-vim'

call plug#end()

" color schemes
if (has("termguicolors"))
 set termguicolors
endif
syntax enable
colorscheme gruvbox

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
autocmd FileType CHADTree nmap <silent> <buffer> B :lcd ..<cr>

" ',' repeats last macro
nnoremap , @@

" Tab and S-Tab control indentation in normal mode
nnoremap <Tab> >>
nnoremap <S-Tab> <<
vnoremap <Tab> >>
vnoremap <S-Tab> <<

" Telescope bindings
noremap <C-p> :Telescope find_files <CR>
noremap <C-f> :Telescope treesitter<CR>

" Movement keys while in insert mode
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" Coc bindings
let mapleader = " "
nmap <leader>rn <Plug>(coc-rename)
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)

" Zen mode bindings
nmap <silent> <leader>zm :TZMinimalist<cr>
nmap <silent> <leader>zf :TZFocus<cr>
nmap <silent> <leader>zn :TZAtaraxis <cr> :AirlineRefresh<cr>

" Launch markdown preview binding
nmap <leader>md <Plug>MarkdownPreview

" Tab selects coc dropdown option
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Remove vim bg, so kitty bg image will show
hi Normal guibg=none ctermbg=none
