-- UI相关插件配置
return {
  -- 状态栏
  {
    "vim-airline/vim-airline",
    event = "VeryLazy",
    config = function()
      vim.g["airline#extensions#tabline#enabled"] = 1
    end,
  },

  -- 文件图标
  {
    "kyazdani42/nvim-web-devicons",
    lazy = true,
  },

  -- 彩虹括号
  {
    "luochen1990/rainbow",
    event = "BufReadPre",
    config = function()
      vim.g.rainbow_active = 1
    end,
  },

  -- 文件浏览器
  {
    "scrooloose/nerdtree",
    cmd = { "NERDTreeToggle", "NERDTree" },
    dependencies = {
      "Xuyuanp/nerdtree-git-plugin",
    },
    keys = {
      { "<C-e>", ":NERDTreeToggle<CR>", desc = "Toggle NERDTree" },
    },
    config = function()
      -- NERDTree配置已在autocmds.lua中设置
    end,
  },

  -- 浮动终端
  {
    "voldikss/vim-floaterm",
    cmd = { "FloatermNew", "FloatermToggle" },
    keys = {
      { "<leader>fn", ":FloatermNew<CR>", desc = "New floating terminal" },
      { "<leader>ft", ":FloatermToggle<CR>", desc = "Toggle floating terminal" },
    },
    config = function()
      vim.g.floaterm_keymap_new = "<Leader>fn"
      vim.g.floaterm_keymap_toggle = "<Leader>ft"
      vim.g.floaterm_type = "floating"
      vim.g.floaterm_position = "center"
    end,
  },
}