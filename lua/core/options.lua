-- 核心Vim选项设置
local opt = vim.opt

-- 外观设置
opt.number = true
opt.encoding = "utf-8"
opt.fileencodings = "ucs-bom,utf-8,cp936,gbk,big5,latin1"
-- opt.fileformat = "unix"       -- Disabled: Let Neovim auto-detect file format
opt.fileformats = "unix,dos,mac"  -- Support all formats and preserve original format
opt.termguicolors = true
vim.cmd("syntax on")

-- 编辑设置
opt.autoindent = true
opt.cindent = true
opt.tabstop = 4
opt.expandtab = true
opt.shiftwidth = 4
opt.mouse = "a"

-- 搜索设置
opt.incsearch = true
opt.ignorecase = true

-- 折叠设置
opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
opt.foldmethod = "manual"
opt.foldexpr = ""

-- 状态栏设置
opt.laststatus = 2

-- 其他设置
vim.g.ai = false

-- 颜色主题设置
vim.cmd("colorscheme monokai")
