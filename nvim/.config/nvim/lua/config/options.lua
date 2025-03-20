-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

opt.wrap = true
opt.spell = false
-- vim.g.lazyvim_picker = "telescope"

vim.opt.fileencodings = { "utf-8", "gbk", "latin1" }
