-- Setup language servers
-- Load server definitions directly to avoid the deprecated `require('lspconfig')[server]` path.
local lspconfig_configs_ok, lspconfig_configs = pcall(require, 'lspconfig.configs')
if not lspconfig_configs_ok then
  return
end

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
      "--fallback-style=google",  -- Use Google C++ style
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

local function get_server(server_name)
  if not lspconfig_configs[server_name] then
    local ok, config_def = pcall(require, 'lspconfig.configs.' .. server_name)
    if not ok then
      return nil, config_def
    end
    lspconfig_configs[server_name] = config_def
  end

  return lspconfig_configs[server_name]
end

-- Function to setup a single LSP server
local function setup_server(server_name, config)
  -- Load the server config and set it up without hitting lspconfig's deprecated lookup path.
  local success, err = pcall(function()
    local server, load_err = get_server(server_name)
    if not server then
      error(load_err)
    end

    if server and server.setup then
      server.setup(config or {})
    end
  end)

  if not success then
    -- Silently ignore "server not found" errors - these happen when
    -- mason-lspconfig tries to setup servers that aren't installed yet
    if err and not (
      err:match("Cannot access configuration")
      or err:match("__index")
      or err:match("module 'lspconfig%.configs%..-' not found")
    ) then
      print(string.format("[LSP] Setup error for '%s': %s", server_name, err))
    end
  end
end

-- Try to use mason-lspconfig if available
local mason_lspconfig_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')

if mason_lspconfig_ok and mason_lspconfig.setup_handlers then
  -- Setup handlers for mason-lspconfig
  -- Only use the default handler - it will apply custom configs from server_configs table
  mason_lspconfig.setup_handlers {
    -- Default handler for all servers
    function(server_name)
      local config = server_configs[server_name] or {}
      setup_server(server_name, config)
    end,
  }
else
  -- Setup each server manually (fallback when mason-lspconfig is not available)
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
  group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }

    -- Smart = formatting: Use LSP formatting instead of native Vim indenting
    vim.keymap.set('v', '=', function()
      -- Get the visual selection range
      local start_pos = vim.fn.getpos("'<")
      local end_pos = vim.fn.getpos("'>")
      local start_line = start_pos[2]
      local end_line = end_pos[2]

      -- Format only the selected range
      vim.lsp.buf.format({
        async = false,
        range = {
          start = { start_line, 0 },
          ["end"] = { end_line, 0 },
        }
      })
    end, vim.tbl_extend('force', opts, { desc = 'Format selection (LSP)' }))

    vim.keymap.set('n', '==', function()
      -- Format only current line
      local line = vim.fn.line('.')
      vim.lsp.buf.format({
        async = false,
        range = {
          start = { line, 0 },
          ["end"] = { line, 0 },
        }
      })
    end, vim.tbl_extend('force', opts, { desc = 'Format current line (LSP)' }))

    -- Use Telescope for LSP navigation (provides better UI and auto-closes)
    local telescope_builtin = require('telescope.builtin')
    vim.keymap.set('n', 'gd', telescope_builtin.lsp_definitions, opts)
    vim.keymap.set('n', 'gr', telescope_builtin.lsp_references, opts)
    vim.keymap.set('n', 'gi', telescope_builtin.lsp_implementations, opts)
    vim.keymap.set('n', '<space>ds', telescope_builtin.lsp_document_symbols, opts)
    vim.keymap.set('n', '<space>ws', telescope_builtin.lsp_dynamic_workspace_symbols, opts)

    -- Standard LSP mappings
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
