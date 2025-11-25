_G.virtual_text_enabled = true

vim.diagnostic.config({
	virtual_text = {
		severity_sort = true,
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		focusable = false,
		close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
		border = 'rounded',
		source = 'always',
		header = '',
		prefix = '',
		scope = 'line',
	}
})

vim.lsp.config('clangd', {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--completion-style=detailed",
		"--header-insertion=iwyu",
		"--suggest-missing-includes",
		"--all-scopes-completion",
		"--cross-file-rename",
	},
	init_options = {
		fallbackFlags = {
			"-Wall",
			"-std=c17",
			"-xc",
			"-I/usr/include",
			"I/usr/local/include",
			"-I" .. vim.fn.getcwd() .. "/include",
		}
	}
})

vim.lsp.config('kotlin_lsp', {
	cmd = { "kotlin-lsp", "--stdio" },
	single_file_support = true,
	filetypes = { "kotlin" },
	root_markers = { "build.gradle", "build.gradle.kts", "pom.xml" },
})

vim.lsp.config('hls', {
	filetypes = { 'haskell', 'lhaskell', 'cabal' },
})

-- other plugin manages my rust lsp
-- vim.lsp.config('rust_analyzer', {
-- 	settings = {
-- 		['rust-analyzer'] = {
-- 			diagnostics = {
-- 				enable = true,
-- 			}
-- 		}
-- 	}
-- })

-- Enable locally installed LSPs
vim.lsp.enable('kotlin_lsp')
vim.lsp.enable('hls')
-- vim.lsp.enable('rust_analyzer')
vim.lsp.enable('ocamllsp')

-- Give the rest to mason
require("mason-lspconfig").setup()
