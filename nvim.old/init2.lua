require'plugins'
require'keymappings'

local cmd = vim.cmd
local exec = vim.api.nvim_exec
local api = vim.api
local opt = vim.opt
local g = vim.g

exec [[
aug commentary
    au!
    au FileType c,cpp,s setlocal commentstring=//%s
    au FileType vert,frag,tesc,tese,geom,comp,glsl,vs,fs setlocal commentstring=//%s
aug END
]]

g.mapleader = ' '

opt.title = true
opt.title = true
opt.showmatch = true
opt.rnu = true
opt.ignorecase = true
opt.
opt.hlsearch = true
opt.incsearch = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smarttab = true
opt.number = true
opt.clipboard = 'unnamedplus'

cmd 'filetype plugin indent on'

api.nvim_set_keymap('v', '<leader>rn')
