-- 编辑增强插件配置
return {
  -- 代码对齐
  {
    "junegunn/vim-easy-align",
    keys = {
      { "ga", "<Plug>(EasyAlign)", mode = { "n", "x" }, desc = "Easy Align" },
    },
  },

  -- 注释插件
  {
    "scrooloose/nerdcommenter",
    keys = {
      { "<leader>/", "<plug>NERDCommenterToggle", desc = "Toggle comment" },
    },
  },

  -- 包围操作
  {
    "tpope/vim-surround",
    keys = {
      { "ys", desc = "Add surround" },
      { "cs", desc = "Change surround" },
      { "ds", desc = "Delete surround" },
      { "S", mode = "v", desc = "Surround visual" },
    },
  },

  -- 多光标编辑
  {
    "terryma/vim-multiple-cursors",
    keys = {
      { "<C-n>", desc = "Multi cursor next" },
      { "<C-p>", desc = "Multi cursor prev" },
      { "<C-x>", desc = "Multi cursor skip" },
      { "g<C-n>", desc = "Multi cursor start" },
    },
    config = function()
      vim.g.multi_cursor_use_default_mapping = 0
      vim.g.multi_cursor_start_word_key = "<C-n>"
      vim.g.multi_cursor_select_all_word_key = "<A-n>"
      vim.g.multi_cursor_start_key = "g<C-n>"
      vim.g.multi_cursor_select_all_key = "g<A-n>"
      vim.g.multi_cursor_next_key = "<C-n>"
      vim.g.multi_cursor_prev_key = "<C-p>"
      vim.g.multi_cursor_skip_key = "<C-x>"
      vim.g.multi_cursor_quit_key = "<Esc>"
    end,
  },

  -- 快速移动
  {
    "easymotion/vim-easymotion",
    keys = {
      { "<leader><leader>", desc = "Easy motion" },
    },
  },

  -- 语法检查
  {
    "vim-syntastic/syntastic",
    event = { "BufReadPre", "BufNewFile" },
  },

  -- 文档生成
  {
    "vim-scripts/DoxygenToolkit.vim",
    ft = { "c", "cpp", "python", "java" },
    config = function()
      vim.g.DoxygenToolkit_authorName = "Tofu Mo"
      vim.g.doxygenToolkit_briefTag_funcName = "yes"
    end,
  },

  -- GitHub Copilot
  {
    "github/copilot.vim",
    event = "VeryLazy",
    config = function()
      -- 启用 Tab 补全
      vim.g.copilot_no_tab_map = false
      vim.g.copilot_assume_mapped = false
      -- 或者使用自定义 Tab 映射
      vim.cmd([[
        imap <silent><script><expr> <Tab> copilot#Accept("\<Tab>")
        let g:copilot_no_tab_map = v:true
      ]])
    end,
  },
}