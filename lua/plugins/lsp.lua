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

  -- LSP配置
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- 直接加载LSP配置，它会自动处理mason-lspconfig的可用性
      require("plugin_configs.lsp")
    end,
  },

  -- Mason与lspconfig的桥接
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = true,
    dependencies = {
      "williamboman/mason.nvim",
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
    end,
  },
}