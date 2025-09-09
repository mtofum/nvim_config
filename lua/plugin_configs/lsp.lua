-- Setup language servers with safe loading
local lspconfig = require('lspconfig')

-- Custom server configurations
local server_configs = {
  -- C/C++ Language Server
  clangd = {
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--function-arg-placeholders",
      "--fallback-style=llvm",
    },
  },
  
  -- Python Language Server
  pyright = {
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic",
        },
      },
    },
  },
  
  -- Bash Language Server
  bashls = {},
  
  -- TypeScript Language Server
  ts_ls = {},
  
  -- Rust Language Server with custom settings
  rust_analyzer = {
    settings = {
      ['rust-analyzer'] = {
        diagnostics = {
          enable = true,
        },
      },
    },
  },
}

-- Function to setup a single LSP server
local function setup_server(server_name, config)
  local server_available = lspconfig[server_name] ~= nil
  if server_available then
    lspconfig[server_name].setup(config or {})
    print("✓ LSP server configured:", server_name)
  else
    print("✗ LSP server not available:", server_name)
  end
end

-- Try to use mason-lspconfig if available, otherwise setup manually
local mason_lspconfig_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')

if mason_lspconfig_ok and mason_lspconfig.setup_handlers then
  print("🔧 Using mason-lspconfig for LSP setup")
  
  -- Setup handlers for mason-lspconfig
  mason_lspconfig.setup_handlers {
    -- Default handler for all servers
    function(server_name)
      local config = server_configs[server_name] or {}
      setup_server(server_name, config)
    end,
    
    -- Custom handlers for specific servers
    ["clangd"] = function()
      setup_server("clangd", server_configs.clangd)
    end,
    ["pyright"] = function()
      setup_server("pyright", server_configs.pyright)
    end,
    ["bashls"] = function()
      setup_server("bashls", server_configs.bashls)
    end,
    ["ts_ls"] = function()
      setup_server("ts_ls", server_configs.ts_ls)
    end,
    ["rust_analyzer"] = function()
      setup_server("rust_analyzer", server_configs.rust_analyzer)
    end,
  }
else
  print("🔧 mason-lspconfig not available, setting up LSP servers manually")
  
  -- Setup each server manually
  for server_name, config in pairs(server_configs) do
    setup_server(server_name, config)
  end
end


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

