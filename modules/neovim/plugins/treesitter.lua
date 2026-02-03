require('nvim-treesitter.configs').setup({
	ensure_installed = {
		"vim", "lua", "vimdoc",
		"html", "css", "kotlin", "c", "commonlisp", "bash",
		"yaml", "json", "latex", "haskell", "rust"
	},
	auto_install = true,
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
})
