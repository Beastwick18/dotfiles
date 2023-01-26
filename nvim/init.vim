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
set foldmethod=syntax       " Fold based on syntax
set nofoldenable
set foldlevel=99
let mapleader = " "         " Use space as leader
set encoding=utf-8
set fileencoding=utf-8
set noswapfile
set nohlsearch
set nobackup
set ch=0
filetype plugin on
set conceallevel=2

map <F1> <nop>
imap <F1> <nop>


" vs = right, hs = bottom
set splitbelow splitright

" Automatically go into insert when entering a vim terminal, change back to
" normal when leaving
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert
" Use escape to go back to normal mode while in terminal mode
tnoremap <Esc> <C-\><C-n>

call plug#begin('~/.config/nvim/plugged')
"{{ Theming
    Plug 'morhetz/gruvbox'
    " Plug 'ghifarit53/tokyonight-vim'
    Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'Pocco81/TrueZen.nvim'
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'xiyaowong/nvim-transparent'

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
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-sleuth'

"{{ Syntax }}
    Plug 'cespare/vim-toml', { 'branch': 'main' }
    Plug 'dag/vim-fish'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Plug 'jackguo380/vim-lsp-cxx-highlight'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'p00f/nvim-ts-rainbow'
    " Plug 'frazrepo/vim-rainbow'
    Plug 'honza/vim-snippets'
    Plug 'ARM9/arm-syntax-vim'
    Plug 'dkarter/bullets.vim'
    Plug 'plasticboy/vim-markdown'
    Plug 'godlygeek/tabular'
    Plug 'fladson/vim-kitty'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'tikhomirov/vim-glsl'
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}

"{{ Other }}
    " Plug 'kana/vim-submode'
    Plug 'vimwiki/vimwiki', { 'branch': 'dev' }

call plug#end()

let g:transparent_enabled = v:true

" Set vim commentary to use // for c and c++ file types
aug commentary
    au!
    au FileType c,cpp,s setlocal commentstring=//%s
    au FileType vert,frag,tesc,tese,geom,comp,glsl,vs,fs setlocal commentstring=//%s
aug END

" let g:gruvbox_contrast_dark='hard'
" let g:italicize_strings=1
" let g:gruvbox_italic=1
" let g:gruvbox_improved_strings=1
" let g:gruvbox_improved_warnings=1

let g:vimwiki_global_ext = 0
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_root = '~/VimWiki'
let g:vimwiki_listsyms = '✗○◐●✓'
let g:vimwiki_list = [{'path': '~/VimWiki', 'syntax': 'markdown', 'ext': '.md'}]
autocmd FileType vimwiki set ft=markdown

noremap ;w :w<CR>
noremap ;q :q<CR>
noremap ;Q :q!<CR>
noremap ' `

noremap <leader>w <C-w>

" color schemes
if (has("termguicolors"))
 set termguicolors
endif
syntax enable

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
augroup Arm
    au!
    au FileType s,S setfiletype arm
    au FileType s,S set syntax=arm
    " au WinNew,BufWinEnter,WinEnter,BufNewFile,BufRead,BufReadPost *.s,*.S setfiletype arm " arm = armv6/7
    " au WinNew,BufWinEnter,WinEnter,BufNewFile,BufRead,BufReadPost *.s,*.S set syntax=arm " arm = armv6/7
augroup END

" let g:tokyonight_style = "night"
" let g:tokyonight_italic_functions = 1
" let g:tokyonight_transparent = 1

lua << EOF
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
vim.g.tokyonight_transparent = true
vim.g.tokyonight_transparent_sidebar = true

-- Load the colorscheme
vim.cmd[[colorscheme tokyonight]]
EOF
" colorscheme dracula
" colorscheme gruvbox
" Airling theme
" let g:airline_theme='tokyonight'
let g:airline_powerline_fonts = 1
    " Disable airline trailing whitespace warning
autocmd VimEnter * silent AirlineToggleWhitespace



" Make tabs persist
imap <Return> <Return><Space><BS>
inoremap {<CR> {<CR>}<Esc>O<Space><BS>
nmap o o<Space><BS>
nmap O O<Space><BS>

" Move through wrapped text naturally
nnoremap j gj
nnoremap k gk

map K {
map J }
noremap H ^
noremap L $

" CHADTree bindings
nnoremap <C-\> <cmd>CHADopen<CR>
inoremap <C-\> <cmd>CHADopen<CR>
    " Allow moving cwd up a directory in CHADTree
autocmd FileType CHADTree nmap <silent> <buffer> B :cd ..<cr>
    " Close chadtree if it is the last window open
autocmd BufEnter * if (winnr("$") == 1 && &filetype == "CHADTree") | q | endif
let g:chadtree_settings = {
    \ 'keymap.jump_to_current': [],
    \ 'keymap.stat': [],
    \ 'keymap.toggle_version_control': ['z']
\} 

" ',' repeats last macro
nnoremap , @@

" cib, dib, etc. don't do anything, rebind to ciB, ...
nnoremap cib ciB
nnoremap dib diB
nnoremap vib viB
nnoremap yib yiB
nnoremap zfib zfiB

" Tab and S-Tab control indentation in normal mode
nnoremap <Tab> >>
nnoremap <S-Tab> <<
vnoremap <Tab> >
vnoremap <S-Tab> <
inoremap <S-Tab> <Esc><<a
imap <tab> <esc><tab>4la

" Telescope bindings
noremap <silent> <leader>ff :Telescope current_buffer_fuzzy_find<CR>
noremap <silent> <leader>fl :Telescope find_files<CR>
noremap <silent> <leader>gs :Telescope git_status<CR>
noremap <silent> <leader>gsh :Telescope git_stash<CR>
noremap <silent> <leader>ts :Telescope treesitter<CR>

" Movement keys while in insert mode
imap <C-k> <Up>
imap <C-j> <Down>
imap <C-h> <Left>
imap <C-l> <Right>

" Move line up or down with Alt+(k/j)
nnoremap <M-k> :m -2<cr>
nnoremap <M-j> :m +1<cr>
inoremap <M-k> <right><ESC>:m -2<cr>i
inoremap <M-j> <right><ESC>:m +1<cr>i

" Coc bindings
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>qf <Plug>(coc-fix-current)
nmap cn <Plug>(coc-rename)
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

nmap <silent> <C-j> <Plug>(VM-Add-Cursor-Down)
nmap <silent> <C-k> <Plug>(VM-Add-Cursor-Up)

" Zen mode bindings
nmap <silent> <leader>zm :TZMinimalist<cr>
nmap <silent> <leader>zf :TZFocus<cr>
nmap <silent> <leader>zn :TZAtaraxis<cr> :AirlineRefresh<cr>

" Launch markdown preview binding
nmap <leader>md <Plug>MarkdownPreviewToggle

" Remove vim bg, so kitty bg image will show
hi Normal guibg=none ctermbg=none

lua <<EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = {"cpp", "python", "c"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
    ignore_install = { "javascript" }, -- List of parsers to ignore installing
    highlight = {
        enable = true,              -- false will disable the whole extension
        -- disable = { "vim" },  -- list of language that will be disabled
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
    rainbow = {
        enable = true,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
    },
}
EOF

