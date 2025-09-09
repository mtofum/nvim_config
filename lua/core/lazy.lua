-- Lazy.nvim 插件管理器配置和引导

-- 安装lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- 最新稳定版本
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 配置lazy.nvim
require("lazy").setup({
  spec = {
    -- 从plugins目录导入所有插件配置
    { import = "plugins" },
  },
  defaults = {
    lazy = true, -- 默认启用懒加载
  },
  install = {
    -- 使用中国镜像加速下载（可选）
    -- colorscheme = { "monokai" },
  },
  checker = {
    enabled = true, -- 自动检查插件更新
    notify = false, -- 不显示更新通知
  },
  performance = {
    rtp = {
      -- 禁用一些不需要的内置插件
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})