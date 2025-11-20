-- 编辑增强插件配置
return {
  -- 代码对齐
  {
    "junegunn/vim-easy-align",
    keys = {
      { "ga", "<Plug>(EasyAlign)", mode = { "n", "x" }, desc = "Easy Align" },
    },
  },

  -- 注释插件
  {
    "scrooloose/nerdcommenter",
    keys = {
      { "<leader>/", "<plug>NERDCommenterToggle", desc = "Toggle comment" },
    },
  },

  -- 包围操作
  {
    "tpope/vim-surround",
    keys = {
      { "ys", desc = "Add surround" },
      { "cs", desc = "Change surround" },
      { "ds", desc = "Delete surround" },
      { "S", mode = "v", desc = "Surround visual" },
    },
  },

  -- 多光标编辑
  {
    "terryma/vim-multiple-cursors",
    keys = {
      { "<C-n>", desc = "Multi cursor next" },
      { "<C-p>", desc = "Multi cursor prev" },
      { "<C-x>", desc = "Multi cursor skip" },
      { "g<C-n>", desc = "Multi cursor start" },
    },
    config = function()
      vim.g.multi_cursor_use_default_mapping = 0
      vim.g.multi_cursor_start_word_key = "<C-n>"
      vim.g.multi_cursor_select_all_word_key = "<A-n>"
      vim.g.multi_cursor_start_key = "g<C-n>"
      vim.g.multi_cursor_select_all_key = "g<A-n>"
      vim.g.multi_cursor_next_key = "<C-n>"
      vim.g.multi_cursor_prev_key = "<C-p>"
      vim.g.multi_cursor_skip_key = "<C-x>"
      vim.g.multi_cursor_quit_key = "<Esc>"
    end,
  },

  -- 快速移动
  {
    "easymotion/vim-easymotion",
    keys = {
      { "<leader><leader>", desc = "Easy motion" },
    },
  },

  -- 语法检查
  {
    "vim-syntastic/syntastic",
    event = { "BufReadPre", "BufNewFile" },
  },

  -- 文档生成
  {
    "vim-scripts/DoxygenToolkit.vim",
    ft = { "c", "cpp", "python", "java" },
    config = function()
      vim.g.DoxygenToolkit_authorName = "Tofu Mo"
      vim.g.doxygenToolkit_briefTag_funcName = "yes"
    end,
  },

  -- GitHub Copilot (Lua 版本)
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<Tab>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
          layout = {
            position = "bottom",
            ratio = 0.4,
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
      })
    end,
  },

  -- Copilot Chat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" }, -- 可选，用于集成
    },
    cmd = {
      "CopilotChat",
      "CopilotChatOpen",
      "CopilotChatClose",
      "CopilotChatToggle",
      "CopilotChatReset",
      "CopilotChatExplain",
      "CopilotChatReview",
      "CopilotChatFix",
      "CopilotChatOptimize",
      "CopilotChatDocs",
      "CopilotChatTests",
      "CopilotChatFixDiagnostic",
    },
    keys = {
      { "<leader>cc", ":CopilotChatToggle<CR>", desc = "Toggle Copilot Chat" },
      { "<leader>ce", ":CopilotChatExplain<CR>", mode = { "n", "v" }, desc = "Explain code" },
      { "<leader>ct", ":CopilotChatTests<CR>", mode = { "n", "v" }, desc = "Generate tests" },
      { "<leader>cf", ":CopilotChatFix<CR>", mode = { "n", "v" }, desc = "Fix code" },
      { "<leader>co", ":CopilotChatOptimize<CR>", mode = { "n", "v" }, desc = "Optimize code" },
      { "<leader>cd", ":CopilotChatDocs<CR>", mode = { "n", "v" }, desc = "Generate docs" },
      { "<leader>cq", function()
        local input = vim.fn.input("Quick Chat: ")
        if input ~= "" then
          require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
        end
      end, desc = "Quick chat" },
      {
        "<leader>cp",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end,
        desc = "Prompt actions (Telescope)",
        mode = { "n", "v" },
      },
    },
    config = function()
      require("CopilotChat").setup({
        debug = false,
        model = "gpt-4",
        temperature = 0.1,

        -- 问答窗口配置
        question_header = "## User ",
        answer_header = "## Copilot ",
        error_header = "## Error ",

        -- 自动触发建议
        auto_follow_cursor = true,
        auto_insert_mode = false,
        clear_chat_on_new_prompt = false,

        -- 上下文
        context = nil,

        -- 选择
        selection = function(source)
          return require("CopilotChat.select").visual(source) or require("CopilotChat.select").buffer(source)
        end,

        -- Telescope 集成
        prompts = {
          Explain = {
            prompt = "/COPILOT_EXPLAIN 选中的代码",
          },
          Review = {
            prompt = "/COPILOT_REVIEW 选中的代码",
          },
          Fix = {
            prompt = "/COPILOT_GENERATE 这段代码有 bug，请帮我修复",
          },
          Optimize = {
            prompt = "/COPILOT_GENERATE 优化选中的代码以提高性能和可读性",
          },
          Docs = {
            prompt = "/COPILOT_GENERATE 请为选中的代码添加文档注释",
          },
          Tests = {
            prompt = "/COPILOT_GENERATE 请为选中的代码生成测试用例",
          },
          FixDiagnostic = {
            prompt = "请帮我解决文件中的以下诊断问题:",
            selection = require("CopilotChat.select").diagnostics,
          },
        },

        -- 窗口配置
        window = {
          layout = "float", -- 'vertical', 'horizontal', 'float'
          width = 0.8,
          height = 0.8,
          relative = "editor",
          border = "rounded",
          title = "Copilot Chat",
        },

        -- 映射
        mappings = {
          complete = {
            detail = "Use @<Tab> or /<Tab> for options.",
            insert = "<Tab>",
          },
          close = {
            normal = "q",
            insert = "<C-c>",
          },
          reset = {
            normal = "<C-r>",
            insert = "<C-r>",
          },
          submit_prompt = {
            normal = "<CR>",
            insert = "<C-s>",
          },
          accept_diff = {
            normal = "<C-y>",
            insert = "<C-y>",
          },
          yank_diff = {
            normal = "gy",
          },
          show_diff = {
            normal = "gd",
          },
          show_system_prompt = {
            normal = "gp",
          },
          show_user_selection = {
            normal = "gs",
          },
        },
      })

      -- 自动命令：在诊断错误时显示修复建议
      vim.api.nvim_create_autocmd("DiagnosticChanged", {
        callback = function()
          local diagnostics = vim.diagnostic.get(0)
          if #diagnostics > 0 then
            -- 可选：自动打开 CopilotChat 来修复诊断
            -- vim.cmd("CopilotChatFixDiagnostic")
          end
        end,
      })
    end,
  },
}
