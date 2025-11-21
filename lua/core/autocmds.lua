-- 自动命令配置
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- 保存时自动删除行末空格
autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    -- 删除行末尾的空格
    -- 保存当前光标位置
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    -- 删除所有行末的空白字符（空格和制表符）
    vim.cmd([[%s/\s\+$//e]])
    -- 恢复光标位置
    pcall(vim.api.nvim_win_set_cursor, 0, cursor_pos)
  end,
  group = augroup("AutoCleanup", { clear = true })
})

-- 设备树文件特定设置 (.dts, .dtsi)
autocmd("FileType", {
  pattern = "dts",
  callback = function()
    vim.opt_local.expandtab = false  -- 使用制表符而非空格
    vim.opt_local.tabstop = 8        -- 制表符显示宽度
    vim.opt_local.shiftwidth = 8     -- 缩进宽度
    vim.opt_local.softtabstop = 8
  end,
  group = augroup("DeviceTreeSettings", { clear = true })
})

-- 为 .dts 和 .dtsi 文件设置文件类型
autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.dts", "*.dtsi"},
  callback = function()
    vim.bo.filetype = "dts"
  end,
  group = augroup("DeviceTreeFileType", { clear = true })
})

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