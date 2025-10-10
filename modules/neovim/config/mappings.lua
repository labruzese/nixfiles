-- load nvchad mappings
require "nvchad.mappings"
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

-- LSP (built-in vim.lsp)
map('n', 'gD', vim.lsp.buf.declaration, { desc = "Go to declaration" })
map('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
map('n', 'K', vim.lsp.buf.hover, { desc = "Show hover documentation" })
map('n', 'gi', vim.lsp.buf.implementation, { desc = "Go to implementation" })
map('n', '<leader>k', vim.lsp.buf.signature_help, { desc = "Show signature help" })
map('n', '<space>D', vim.lsp.buf.type_definition, { desc = "Go to type definition" })
map('n', '<space>rn', vim.lsp.buf.rename, { desc = "Rename symbol" })
map('n', '<space>ca', vim.lsp.buf.code_action, { desc = "Code actions" })
map('n', 'gr', vim.lsp.buf.references, { desc = "Find references" })

-- Diagnostics (built-in vim.diagnostic)
map('n', '[d', vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map('n', ']d', vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map('n', '<space>e', vim.diagnostic.open_float, { desc = "Show diagnostic details" })
map('n', '<space>q', vim.diagnostic.setloclist, { desc = "Add diagnostics to location list" })

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
