-- Treesitter语法高亮配置
return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
      -- 使用现有的treesitter配置
      require("plugin_configs.treesitter")
    end,
  },
}