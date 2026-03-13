local ft_map = {
  c = { "lsp", "treesitter" },
  cpp = { "lsp", "treesitter" },
  objc = { "lsp", "treesitter" },
  objcpp = { "lsp", "treesitter" },
  cuda = { "lsp", "treesitter" },
}

require("ufo").setup({
  open_fold_hl_timeout = 150,
  provider_selector = function(_, filetype, buftype)
    if buftype ~= "" then
      return ""
    end

    return ft_map[filetype] or { "treesitter", "indent" }
  end,
  preview = {
    win_config = {
      border = "rounded",
      winblend = 0,
    },
  },
})
