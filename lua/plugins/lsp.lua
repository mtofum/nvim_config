-- LSP相关插件配置
return {
  -- Mason LSP安装器
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate" },
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end,
  },

  -- Mason与lspconfig的桥接
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup({
        -- 自动安装的LSP服务器
        ensure_installed = {
          "clangd",        -- C/C++
          "pyright",       -- Python
          "bashls",        -- Bash
          "ts_ls",         -- TypeScript
          "rust_analyzer", -- Rust
        },
        -- 自动设置LSP服务器
        automatic_installation = true,
      })
      
      -- 使用现有的LSP配置
      require("plugin_configs.lsp")
    end,
  },

  -- LSP配置
  {
    "neovim/nvim-lspconfig",
    lazy = true,
  },
}