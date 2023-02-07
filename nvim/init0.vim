lua <<EOF
local o = vim.o
local wo = vim.wo
local bo = vim.bo
local k = vim.keymap

o.path = o.path .. '**'
o.mouse = 'a'
o.encoding = 'utf-8'
o.fileencoding = 'utf-8'
o.foldlevel = 99
o.cmdheight = 0
o.conceallevel = 2
o.clipboard ='unnamedplus'
o.foldmethod = 'syntax'
o.wildmode = 'longest,list'
o.tabstop = 4
o.shiftwidth = 4
o.swapfile = false

o.expandtab = true
o.title = true
o.showmatch = true
o.ignorecase = true
o.incsearch = true
o.smarttab = true
o.splitbelow = true
o.splitright = true
o.expandtab = true
o.expandtab = true
o.number = true

o.hlsearch = false
o.showmode = false
o.backup = false
o.foldenable = false

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.vimtex_view_method = 'zathura'
vim.g.transparent_enabled = true
vim.g.vim_markdown_math = 1
vim.g.vim_markdown_folding_disabled = 1
vim.g.rainbow_active = 1
vim.g.chadtree_settings = [[{
    "keymap.jump_to_current": [],
    "keymap.stat": [],
    "keymap.toggle_version_control": ["z"]
}]]

vim.cmd[[colorscheme catppuccin-mocha]]

local nore = { noremap = true }
local silent = { silent = true }
local snore = { noremap = true, silent = true }

k.set('', 'K', '{')
k.set('', 'J', '}')
k.set('', ';w', ':w<CR>', nore)
k.set('', ';q', ':q<CR>', nore)
-- map K {
-- map J }
-- noremap ;w :w<CR>
-- noremap ;q :q<CR>
k.set('', ';Q', ':q!<CR>', nore)
k.set('', "'", '`', nore)
k.set('', '<leader>w', '<C-w>', nore)
k.set('', 'H', '^', nore)
k.set('', 'L', '$', nore)
k.set('n', 'j', 'gj', nore)
k.set('n', 'k', 'gk', nore)
k.set('n', ',', '@@', nore)

k.set('n', 'cib', 'ciB', nore)
k.set('n', 'dib', 'diB', nore)
k.set('n', 'vib', 'viB', nore)
k.set('n', 'yib', 'yiB', nore)
k.set('n', 'zfib', 'zfiB', nore)

k.set('n', '<Tab>', '>>')
k.set('n', '<S-Tab>', '<<')
k.set('n', '<M-k>', ':m -2<cr>')
k.set('n', '<M-j>', ':m +1<cr>')
k.set('v', '<Tab>', '>')
k.set('v', '<S-Tab>', '<')

k.set('i', '<M-k>', '<right><ESC>:m -2<cr>i', nore)
k.set('i', '<M-j>', '<right><ESC>:m +1<cr>i', nore)

-- CHAD bindings
k.set('n', '<C-\\>', '<cmd>CHADopen<CR>', nore)
k.set('i', '<C-\\>', '<cmd>CHADopen<CR>', nore)

-- Persistent tabs
k.set('n', 'o', 'o<Space><BS>')
k.set('n', 'O', 'O<Space><BS>')
k.set('i', '{<CR>', '{<CR>}<Esc>O<Space><BS>')

-- Fugitive bindings
k.set('n', '<leader>gd', ':Gdiffsplit<cr>', snore)
k.set('n', '<leader>gb', ':GBrowse<cr>', snore)
k.set('n', '<leader>gc', ':Git commit<cr> ', snore)
k.set('n', '<leader>ga', ':Git add .<cr>', snore)
k.set('n', '<leader>gp', ':Git push<cr>', snore)
k.set('n', '<C-j>', '<Plug>(VM-Add-Cursor-Down)', snore)
k.set('n', '<C-k>', '<Plug>(VM-Add-Cursor-Up)', snore)

-- Insert mode mappings
k.set('i', '<C-k>', '<Up>')
k.set('i', '<C-j>', '<Down>')
k.set('i', '<C-h>', '<Left>')
k.set('i', '<C-l>', '<Right>')

-- Coc bindings
k.set('n', '<leader>rn', '<Plug>(coc-rename)')
k.set('n', '<leader>qf', '<Plug>(coc-fix-current)')
k.set('n', 'cn', '<Plug>(coc-rename)')
k.set('n', 'gd', '<Plug>(coc-definition)', silent)
k.set('n', '<leader>jy', '<Plug>(coc-type-definition)', silent)
k.set('n', '<leader>ji', '<Plug>(coc-implementation)', silent)
k.set('n', '<leader>jr', '<Plug>(coc-references)', silent)
k.set('i', '<cr>', 'pumvisible() ? coc#_select_confirm() : "<C-g>u<CR><Space><BS>"', snore)

vim.cmd[[packadd packer.nvim]]
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'nvim-lualine/lualine.nvim'
    use { 'catppuccin/nvim', as = 'catppuccin' }
    use { 'nvim-lualine/lualine.nvim' }
    use { 'lukas-reineke/indent-blankline.nvim' }
    use { 'xiyaowong/nvim-transparent' }
    use { 'kyazdani42/nvim-web-devicons' }

    -- File management
    use { 'ms-jpq/chadtree', branch = 'chad', run = 'python3 -m chadtree deps' }

    -- Tim pope
    use { 'tpope/vim-surround' }
    use { 'tpope/vim-commentary' }
    use { 'tpope/vim-repeat' }
    use { 'tpope/vim-sleuth' }
    use { 'tpope/vim-fugitive' }

    -- Syntax highlighting
    use { 'cespare/vim-toml', branch = 'main' }
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'p00f/nvim-ts-rainbow' }
    use { 'fladson/vim-kitty' }
    use { 'plasticboy/vim-markdown' }
    use { 'tikhomirov/vim-glsl' }

    -- Editing
    use { 'mg979/vim-visual-multi', branch = 'master' }

    -- LSP
    use { 'neoclide/coc.nvim', branch = 'release' }
    use { 'lervag/vimtex' }
end)

-- Autocmd
local commentary = vim.api.nvim_create_augroup('commentary', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'c,cpp,s,vert,frag,tesc,tese,geom,comp,glsl,vs,fs',
    group = commentary,
    command='setlocal commentstring=//%s'
})

-- CHADTree group
local chad = vim.api.nvim_create_augroup('chad', { clear = true })

vim.api.nvim_create_autocmd('StdinReadPre', {
    pattern = '*',
    group = chad,
    command='let s:std_in=1'
})

vim.api.nvim_create_autocmd('VimEnter', {
    pattern = '*',
    group = chad,
    command='if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe \'CHADopen\' | wincmd p | ene | exe \'cd \'.argv()[0] | endif'
})

-- Allow moving cwd up a directory in CHADTree
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'CHADTree',
    group = chad,
    command='nmap <silent> <buffer> B :cd ..<cr>'
})

-- Close chadtree if it is the last window open
vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*',
    group = chad,
    command='if (winnr("$") == 1 && &filetype == "CHADTree") | q | endif'
})

-- Setup
require'lualine'.setup {
    options = {
        theme = "catppuccin"
    }
}

require'nvim-treesitter.configs'.setup {
    ensure_installed = {"cpp", "python", "c", "rust"},
    sync_install = false,
    -- ignore_install = { "javascript" },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    },
}
EOF


" set ts=4 sw=4
" set mouse=a
" set encoding=utf-8 fileencoding=utf-8
" set foldlevel=99
" set ch=0
" set conceallevel=2
" set clipboard=unnamedplus
" set foldmethod=syntax
" set wildmode=longest,list

" set title
" set showmatch
" set ignorecase
" set incsearch
" set expandtab
" set sta
" set splitbelow splitright

" set nohlsearch
" set nosmd
" set nobackup
" set nofoldenable

" let mapleader=" "
" let maplocalleader=" "

" filetype plugin on
" hi Normal guibg=none ctermbg=none

" call plug#begin('~/.config/nvim/plugged')
"     " Theming
"     Plug 'nvim-lualine/lualine.nvim'
"     Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
"     Plug 'lukas-reineke/indent-blankline.nvim'
"     Plug 'xiyaowong/nvim-transparent'
"     Plug 'kyazdani42/nvim-web-devicons'

"     " File management
"     Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}

"     " Tim pope
"     Plug 'tpope/vim-surround'
"     Plug 'tpope/vim-commentary'
"     Plug 'tpope/vim-repeat'
"     Plug 'tpope/vim-sleuth'
"     Plug 'tpope/vim-fugitive'

"     " Syntax highlighting
"     Plug 'cespare/vim-toml', { 'branch': 'main' }
"     Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"     Plug 'p00f/nvim-ts-rainbow'
"     Plug 'fladson/vim-kitty'
"     Plug 'plasticboy/vim-markdown'
"     Plug 'tikhomirov/vim-glsl'

"     " Editing
"     Plug 'mg979/vim-visual-multi', {'branch': 'master'}

"     " LSP
"     Plug 'neoclide/coc.nvim', {'branch': 'release'}
"     Plug 'lervag/vimtex'

" call plug#end()

" colorscheme catppuccin-mocha

" let g:vimtex_view_method = 'zathura'
" let g:transparent_enabled = v:true
" let g:vim_markdown_math = 1                " Enable latex
" let g:vim_markdown_folding_disabled = 1
" let g:rainbow_active = 1
let g:chadtree_settings = {
    \ 'keymap.jump_to_current': [],
    \ 'keymap.stat': [],
    \ 'keymap.toggle_version_control': ['z']
\} 

" Misc mappings
" map K {
" map J }
" noremap ;w :w<CR>
" noremap ;q :q<CR>
" noremap ;Q :q!<CR>
" noremap ' `
" noremap <leader>w <C-w>
" noremap H ^
" noremap L $
" nnoremap j gj
" nnoremap k gk
" nnoremap , @@

" Surround
" nnoremap cib ciB
" nnoremap dib diB
" nnoremap vib viB
" nnoremap yib yiB
" nnoremap zfib zfiB

" Tabs
" nnoremap <Tab> >>
" " nnoremap <S-Tab> <<
" " nnoremap <M-k> :m -2<cr>
" " nnoremap <M-j> :m +1<cr>
" " vnoremap <Tab> >
" " vnoremap <S-Tab> <

" " Shifting lines
" inoremap <M-k> <right><ESC>:m -2<cr>i
" inoremap <M-j> <right><ESC>:m +1<cr>i

" " CHAD bindings
" nnoremap <C-\> <cmd>CHADopen<CR>
" inoremap <C-\> <cmd>CHADopen<CR>

" " Persistent tabs
" nmap o o<Space><BS>
" nmap O O<Space><BS>
" imap {<CR> {<CR>}<Esc>O<Space><BS>

" " Fugitive bindings
" nmap <silent> <leader>gd :Gdiffsplit<cr>
" nmap <silent> <leader>gb :GBrowse<cr>
" nmap <silent> <leader>gc :Git commit<cr> 
" nmap <silent> <leader>ga :Git add .<cr>
" nmap <silent> <leader>gp :Git push<cr>
" nmap <silent> <C-j> <Plug>(VM-Add-Cursor-Down)
" nmap <silent> <C-k> <Plug>(VM-Add-Cursor-Up)

" " Insert mode mappings
" imap <C-k> <Up>
" imap <C-j> <Down>
" imap <C-h> <Left>
" imap <C-l> <Right>

" " Coc bindings
" nmap <leader>rn <Plug>(coc-rename)
" nmap <leader>qf <Plug>(coc-fix-current)
" nmap cn <Plug>(coc-rename)
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> <leader>jy <Plug>(coc-type-definition)
" nmap <silent> <leader>ji <Plug>(coc-implementation)
" nmap <silent> <leader>jr <Plug>(coc-references)
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR><Space><BS>"


" " ####################################################### "
" " Autocmd
" aug commentary
"     au!
"     au FileType c,cpp,s,vert,frag,tesc,tese,geom,comp,glsl,vs,fs setlocal commentstring=//%s
" aug END

" " augroup Chad
" "     autocmd!
" "     autocmd StdinReadPre * let s:std_in=1
" "     autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'CHADopen' | wincmd p | ene | exe 'cd '.argv()[0] | endif
" " augroup END

" " Allow moving cwd up a directory in CHADTree
" " autocmd FileType CHADTree nmap <silent> <buffer> B :cd ..<cr>
" " Close chadtree if it is the last window open
" " autocmd BufEnter * if (winnr("$") == 1 && &filetype == "CHADTree") | q | endif

" " Lua
" " lua <<EOF
" " require'lualine'.setup {
" "     options = {
" "         theme = "catppuccin"
" "     }
" " }

" " require'nvim-treesitter.configs'.setup {
" "     ensure_installed = {"cpp", "python", "c", "rust"},
" "     sync_install = false,
" "     -- ignore_install = { "javascript" },
" "     highlight = {
" "         enable = true,
" "         additional_vim_regex_highlighting = false,
" "     },
" "     rainbow = {
" "         enable = true,
" "         extended_mode = true,
" "         max_file_lines = nil,
" "     },
" " }
" " EOF
