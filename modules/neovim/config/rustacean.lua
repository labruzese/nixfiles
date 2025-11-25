return {
	server = {
		on_attach = function(_, bufnr)
			local map = vim.keymap.set

			-- Rust-specific overrides
			map('n', 'K', function() vim.cmd.RustLsp({ 'hover', 'actions' }) end,
				{ buffer = bufnr, desc = "Rust: Hover with actions" })

			map('v', 'K', function() vim.cmd.RustLsp { 'hover', 'range' } end,
				{ buffer = bufnr, desc = "Rust: Hover range" })

			map('n', '<leader>e', function() vim.cmd.RustLsp('renderDiagnostic') end,
				{ buffer = bufnr, desc = "Rust: Render diagnostic" })

			map('n', '<leader>ca', function() vim.cmd.RustLsp('codeAction') end,
				{ buffer = bufnr, desc = "Rust: Code actions (grouped)" })

			-- Additional Rust-specific bindings
			map('n', '<leader>ee', function() vim.cmd.RustLsp('explainError') end,
				{ buffer = bufnr, desc = "Rust: Explain error code" })

			map('n', '<leader>er', function() vim.cmd.RustLsp('relatedDiagnostics') end,
				{ buffer = bufnr, desc = "Rust: Related diagnostics" })

			map('n', '<leader>rc', function() vim.cmd.RustLsp('openCargo') end,
				{ buffer = bufnr, desc = "Rust: Open Cargo.toml" })

			map('n', '<leader>rD', function() vim.cmd.RustLsp('openDocs') end,
				{ buffer = bufnr, desc = "Rust: Open docs.rs" })

			map('n', '<leader>rp', function() vim.cmd.RustLsp('parentModule') end,
				{ buffer = bufnr, desc = "Rust: Parent module" })

			map({ 'n', 'v' }, '<leader>rj', function() vim.cmd.RustLsp('joinLines') end,
				{ buffer = bufnr, desc = "Rust: Join lines" })

			map({ 'n', 'v' }, '<leader>rsr', function() vim.cmd.RustLsp('ssr') end,
				{ buffer = bufnr, desc = "Rust: Structural search replace" })

			map('n', '<leader>rsa', function() vim.cmd.RustLsp { 'workspaceSymbol', 'allSymbols', bang = true } end,
				{ buffer = bufnr, desc = "Rust: All workspace symbols" })

			map('n', '<leader>rst', function() vim.cmd.RustLsp { 'workspaceSymbol', 'onlyTypes' } end,
				{ buffer = bufnr, desc = "Rust: Workspace symbols (types)" })
		end,
	},
}
