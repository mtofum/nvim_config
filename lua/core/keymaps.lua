-- 键位映射配置
local keymap = vim.keymap.set

-- 窗口导航
keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- 剪贴板操作
keymap("v", "<leader>yy", '"+y', { desc = "Copy to system clipboard" })
keymap("n", "<leader>pp", '"+p', { desc = "Paste from system clipboard" })

-- 分屏操作
keymap("n", "sv", ":vsp<CR>", { desc = "Vertical split" })
keymap("n", "sh", ":sp<CR>", { desc = "Horizontal split" })
keymap("n", "st", ":tabe %<CR>", { desc = "New tab" })
keymap("n", "<leader>qq", ":q<CR>", { desc = "Quit" })

-- 终端模式按键
keymap("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal insert mode" })

-- 会话管理
keymap("n", "<leader>ss", ":mksession!<CR> :wviminfo! viminfo<CR>", { desc = "Save session" })
keymap("n", "<leader>rs", ":source Session.vim<CR> :rviminfo! viminfo<CR>", { desc = "Restore session" })

-- NERDTree (将由插件配置覆盖)
keymap("n", "<C-e>", ":NERDTreeToggle<CR>", { desc = "Toggle file explorer" })

-- Telescope (将由插件配置覆盖)
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
keymap("n", "<leader>fw", function() require('telescope.builtin').grep_string{} end, { desc = "Grep string under cursor" })

-- Telescope visual mode
keymap("v", "<leader>ff", '"zy:Telescope find_files default_text=<C-r>z<cr>', { desc = "Find files with selection" })
keymap("v", "<leader>fg", '"zy:Telescope live_grep default_text=<C-r>z<cr>', { desc = "Live grep with selection" })

-- clang-format
keymap("n", "<C-=>", ":pyf ~/.vim/clang-format.py<cr>", { desc = "Format with clang-format" })
keymap("i", "<C-=>", "<c-o>:pyf ~/.vim/clang-format.py<cr>", { desc = "Format with clang-format (insert mode)" })

-- Symbols outline
keymap("n", "<F8>", ":SymbolsOutline<CR>", { desc = "Toggle symbols outline" })

-- Easy align
keymap("x", "ga", "<Plug>(EasyAlign)", { desc = "Easy align (visual)" })
keymap("n", "ga", "<Plug>(EasyAlign)", { desc = "Easy align (normal)" })