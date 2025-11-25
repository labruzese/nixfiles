-- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Treat .h files as C files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.h",
	callback = function()
		vim.bo.filetype = "c"
	end,
	desc = "Treat .h files as C files"
})

-- Set up K to use man with section 3 for C files
vim.api.nvim_create_autocmd("FileType", {
	pattern = "c",
	callback = function()
		vim.bo.keywordprg = "man 3" -- Use man section 3 specifically for library functions
	end,
})

-- Start Hyprland LSP for hyprland config files
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
	pattern = { "*.hl", "hypr*.conf" },
	callback = function()
		vim.lsp.start {
			name = "hyprlang",
			cmd = { "hyprls" },
			root_dir = vim.fn.getcwd(),
		}
	end
})

-- LuaSnip: unlink snippet when leaving insert mode
local ls = require("luasnip")
vim.api.nvim_create_augroup("MyLuaSnip", { clear = true })

vim.api.nvim_create_autocmd("InsertLeave", {
	group = "MyLuaSnip",
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		if ls.session and ls.session.current_nodes[buf] then
			ls.unlink_current()
		end
	end,
})

-- LSP attach
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		local map = vim.keymap.set

		-- LSP goto
		map('n', 'gsd', vim.lsp.buf.declaration, { desc = "Jump to declaration" })
		map('n', 'gd', vim.lsp.buf.definition, { desc = "Jump to definition" })
		map('n', '<leader>gt', vim.lsp.buf.type_definition, { desc = "Jump to type definition" })
		map('n', '<leader>gi', vim.lsp.buf.implementation, { desc = "List implementations" })
		map('n', 'gr', vim.lsp.buf.references, { desc = "List references" })
		map({ 'n', 'i' }, '<C-s>', vim.lsp.buf.signature_help, { desc = "Signature help" })
		map('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Rename symbol" })
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
		map('n', ']d', vim.diagnostic.goto_next, { desc = "Next diagnostic" })
		map('n', '[d', vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
		map('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })
		map('n', '<leader>Q', vim.diagnostic.setqflist, { desc = "Diagnostics to quickfix" })

		if client and client.name == 'rust-analyzer' then
			return
		end

		map('n', 'K', vim.lsp.buf.hover, { desc = "Hover information" })
		map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code actions" })
		map('n', '<leader>e', vim.diagnostic.open_float, { desc = "Show diagnostic float" })
	end,
})
