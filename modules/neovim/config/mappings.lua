local map = vim.keymap.set

-- ignore these buttons (conflict with wezterm)
map('n', '<A-o>', '<Nop>', { desc = "No operation" })
map('i', '<A-o>', '<Nop>', { desc = "No operation" })
map('v', '<A-o>', '<Nop>', { desc = "No operation" })
map('t', '<A-o>', '<Nop>', { desc = "No operation" })

-- Clipboard
map('v', 'y', '"+y', { desc = "Yank to system clipboard (visual mode)" })

-- Terminal
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Window navigation
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })

map('n', '<leader>dt', function()
	local current_setting = vim.diagnostic.config().virtual_text
	if current_setting then
		vim.diagnostic.config({ virtual_text = false })
		print("LSP virtual text disabled")
	else
		vim.diagnostic.config({ virtual_text = true })
		print("LSP virtual text enabled")
	end
end, { desc = "Toggle LSP virtual text" })
