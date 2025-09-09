# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## About This Repository

This is a Neovim configuration repository using lazy.nvim as the plugin manager. It provides a comprehensive IDE-like setup with LSP support, Treesitter syntax highlighting, and numerous productivity plugins with lazy loading for optimal performance.

## Essential Commands

### Plugin Management (Lazy.nvim)
- `:Lazy` - Open lazy.nvim plugin manager interface
- `:Lazy install` - Install all configured plugins
- `:Lazy update` - Update all installed plugins  
- `:Lazy clean` - Remove unused plugins
- `:Lazy check` - Check for plugin updates
- `:Lazy sync` - Run install, clean and update

### LSP and Development
- `:checkhealth` - Check Neovim health including LSP setup
- `:LspInfo` - Display LSP client information
- `:TSUpdate` - Update Treesitter parsers
- `:TSInstallInfo` - Show available Treesitter language parsers

## Architecture Overview

### Core Configuration Structure
- `init.lua` - Main entry point, loads core modules and lazy.nvim
- `lua/core/` - Core configuration modules
  - `options.lua` - Vim options and settings
  - `keymaps.lua` - Key mappings configuration
  - `autocmds.lua` - Auto commands
  - `lazy.lua` - Lazy.nvim bootstrap and configuration
- `lua/plugins/` - Plugin configurations (lazy-loaded)
  - `ui.lua` - UI-related plugins (airline, nerdtree, etc.)
  - `editor.lua` - Editing enhancement plugins
  - `lsp.lua` - LSP configuration
  - `treesitter.lua` - Treesitter configuration
  - `telescope.lua` - Telescope search configuration
  - `languages.lua` - Language-specific plugins
- `lua/plugin_configs/` - Legacy plugin configurations (still used for LSP/Treesitter)
- `colors/` - Custom color schemes (monokai.vim)

### Plugin Architecture
Uses lazy.nvim for plugin management with:
- **Lazy Loading**: Most plugins load on-demand (commands, filetypes, key presses)
- **Event-driven**: Plugins load based on Neovim events
- **Dependency Management**: Automatic handling of plugin dependencies

Key plugins include:
- **LSP**: nvim-lspconfig with support for clangd, pyright, ts_ls, rust_analyzer
- **Syntax**: nvim-treesitter for enhanced syntax highlighting
- **File Management**: NERDTree with git integration
- **Search**: Telescope for fuzzy finding
- **Terminal**: vim-floaterm for floating terminal windows

### LSP Configuration
Language servers configured in `lua/plugin_configs/lsp.lua`:
- C/C++: clangd
- Python: pyright
- Bash: bashls (bash-language-server)
- TypeScript: ts_ls
- Rust: rust_analyzer

### Key Mappings
- Leader key: `<Space>`
- Window navigation: `<Ctrl-h/j/k/l>`
- File tree toggle: `<Ctrl-e>`
- Terminal toggle: `<Leader>ft`
- Find files: `<Leader>ff`
- Live grep: `<Leader>fg`

## Development Dependencies

### Required System Packages
- Python 2/3 with neovim package (`pip install neovim`)
- ripgrep for telescope searching
- Node.js and npm for LSP servers

### LSP Server Installation
Language servers must be installed separately:
- **clangd**: Usually comes with LLVM/Clang installation
- **pyright**: `npm install -g pyright`
- **bash-language-server**: `npm install -g bash-language-server`
- **typescript-language-server**: `npm install -g typescript-language-server`
- **rust-analyzer**: Install via rustup or package manager

### Additional Tools (from readme.md)
- **Bear**: For generating compile_commands.json for C/C++ projects
- **cmake-language-server**: `pip3 install cmake-language-server`
- **GNU Global (gtag)**: For code tagging and navigation

## Configuration Customization

### Adding New Languages
1. Add language server to `lua/plugin_configs/lsp.lua`
2. Add parser to treesitter's `ensure_installed` list
3. Install the language server binary

### Modifying Keybindings
- General mappings in `lua/core/keymaps.lua`
- LSP-specific mappings in `lua/plugin_configs/lsp.lua`
- Plugin-specific mappings in individual plugin config files in `lua/plugins/`

## File Structure Context
This is a personal Neovim configuration located in `~/.config/nvim/`, making it the active Neovim configuration when the user runs `nvim`.