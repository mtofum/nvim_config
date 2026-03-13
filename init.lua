-- Neovim配置主入口文件
-- 使用lazy.nvim作为插件管理器

-- 设置leader键，必须在lazy.nvim之前设置
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 加载核心配置
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- 初始化lazy.nvim和插件
require("core.lazy")

-- Disable putting the replaced text into the default register
vim.keymap.set('x', 'p', '"_dP', { noremap = true, silent = true })
