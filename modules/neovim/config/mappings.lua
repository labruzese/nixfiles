local map = vim.keymap.set

-- Clipboard
map('v', 'y', '"+y', { desc = "Yank to system clipboard (visual mode)" })
map({ 'n', 'v', 'i' }, '<C-c>', '<Esc>gg"+yG``', { desc = "Copy entire file" })

-- Terminal
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Window navigation
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-;>", "<C-w><C-w>", { desc = "Switch focus" })
