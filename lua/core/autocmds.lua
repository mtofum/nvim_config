-- 自动命令配置
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Python文件特定设置
autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.foldmethod = "indent"
    vim.opt_local.expandtab = true
    vim.opt_local.smarttab = true
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
  group = augroup("PythonSettings", { clear = true })
})

-- NERDTree自动命令
autocmd("BufEnter", {
  callback = function()
    if vim.fn.winnr("$") == 1 and 
       vim.fn.exists("b:NERDTree") == 1 and 
       vim.b.NERDTree.isTabTree() then
      vim.cmd("q")
    end
  end,
  group = augroup("NERDTreeSettings", { clear = true })
})