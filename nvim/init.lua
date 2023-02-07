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
local chadtree_settings = {
    ["keymap.jump_to_current"] = {nil},
    ["keymap.stat"] = {nil},
    ["keymap.toggle_version_control"] = {'z'}
}
vim.api.nvim_set_var("chadtree_settings", chadtree_settings)

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
