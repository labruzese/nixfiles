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
