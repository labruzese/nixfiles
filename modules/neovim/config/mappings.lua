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



-- LSP goto
map('n', 'gsd', vim.lsp.buf.declaration, { desc = "Jump to declaration" })
map('n', 'gd', vim.lsp.buf.definition, { desc = "Jump to definition" })
map('n', '<leader>gt', vim.lsp.buf.type_definition, { desc = "Jump to type definition" })
map('n', '<leader>gi', vim.lsp.buf.implementation, { desc = "List implementations" })
map('n', 'gr', vim.lsp.buf.references, { desc = "List references" })
map('n', 'K', vim.lsp.buf.hover, { desc = "Hover information" })
map({ 'n', 'i' }, '<C-s>', vim.lsp.buf.signature_help, { desc = "Signature help" })
map('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Rename symbol" })
map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code actions" })
map('n', '<leader>f', vim.lsp.buf.format, { desc = "Format buffer" })
map('n', 'gO', vim.lsp.buf.document_symbol, { desc = "Document symbols" })
map('n', 'gS', vim.lsp.buf.workspace_symbol, { desc = "Workspace symbols" })
map('n', '<leader>ci', vim.lsp.buf.incoming_calls, { desc = "Incoming calls" })
map('n', '<leader>co', vim.lsp.buf.outgoing_calls, { desc = "Outgoing calls" })

--LSP toggles
map('n', '<leader>dh', function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle LSP inlay hints" })
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

-- LSP diagnostic
map('n', '<leader>e', vim.diagnostic.open_float, { desc = "Show diagnostic float" })
map('n', ']d', vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map('n', '[d', vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })
map('n', '<leader>Q', vim.diagnostic.setqflist, { desc = "Diagnostics to quickfix" })
