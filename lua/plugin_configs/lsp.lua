-- Setup language servers with mason-lspconfig integration
local lspconfig = require('lspconfig')
local mason_lspconfig = require('mason-lspconfig')

-- Default LSP server setup function
local function default_setup(server_name)
  lspconfig[server_name].setup {}
end

-- Custom server configurations
local server_configs = {
  -- Rust Language Server with custom settings
  rust_analyzer = function()
    lspconfig.rust_analyzer.setup {
      settings = {
        ['rust-analyzer'] = {
          diagnostics = {
            enable = true,
          },
        },
      },
    }
  end,
  
  -- Python Language Server
  pyright = function()
    lspconfig.pyright.setup {
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "basic",
          },
        },
      },
    }
  end,
  
  -- C/C++ Language Server
  clangd = function()
    lspconfig.clangd.setup {
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=llvm",
      },
    }
  end,
  
  -- Bash Language Server
  bashls = function()
    lspconfig.bashls.setup {}
  end,
  
  -- TypeScript Language Server
  ts_ls = function()
    lspconfig.ts_ls.setup {}
  end,
}

-- Setup handlers for mason-lspconfig
mason_lspconfig.setup_handlers {
  -- Default handler for all servers
  default_setup,
  
  -- Custom handlers for specific servers
  ["rust_analyzer"] = server_configs.rust_analyzer,
  ["pyright"] = server_configs.pyright,
  ["clangd"] = server_configs.clangd,
  ["bashls"] = server_configs.bashls,
  ["ts_ls"] = server_configs.ts_ls,
}


-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

