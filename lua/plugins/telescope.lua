-- Telescope搜索插件配置
return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
      { "<leader>fw", function() require('telescope.builtin').grep_string{} end, desc = "Grep string under cursor" },
      -- Visual mode mappings
      { "<leader>ff", '"zy:Telescope find_files default_text=<C-r>z<cr>', mode = "v", desc = "Find files with selection" },
      { "<leader>fg", '"zy:Telescope live_grep default_text=<C-r>z<cr>', mode = "v", desc = "Live grep with selection" },
    },
  },

  -- Plenary (Telescope依赖)
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
}