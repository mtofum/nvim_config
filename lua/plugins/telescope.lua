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
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')

      telescope.setup({
        defaults = {
          -- Default mappings for all pickers
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<CR>"] = actions.select_default,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            },
            n = {
              ["<CR>"] = actions.select_default,
              ["q"] = actions.close,
            },
          },
          -- Show preview window
          preview = {
            enable = true,
          },
        },
        pickers = {
          -- LSP pickers configuration
          lsp_references = {
            show_line = true,
            trim_text = true,
            include_declaration = false,
          },
          lsp_definitions = {
            show_line = true,
            trim_text = true,
          },
          lsp_implementations = {
            show_line = true,
            trim_text = true,
          },
          lsp_document_symbols = {
            show_line = true,
            symbol_width = 50,
          },
          lsp_dynamic_workspace_symbols = {
            show_line = true,
          },
        },
      })
    end,
  },

  -- Plenary (Telescope依赖)
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
}