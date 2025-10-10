-- config/lazy.lua

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	-- NVCHAD BASE
	{
		"NvChad/NvChad",
		lazy = false,
		branch = "v2.5",
		import = "nvchad.plugins",
	},
	{
		"NvChad/base46",
		lazy = false,
		build = function()
			require("base46").load_all_highlights()
		end,
	},

	-- TREESITTER
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require('plugins.treesitter')
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require('treesitter-context').setup({})
		end,
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		config = function()
			require('plugins.lspconfig')
		end,
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require('mason').setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
		config = function()
			require('mason-lspconfig').setup({
				automatic_installation = true,
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		config = function()
			require('plugins.conform')
		end,
	},

	-- AUTOCOMPLETE
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			require('plugins.cmp')
		end,
	},

	-- FILE EXPLORER
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require('plugins.oil')
		end,
	},

	-- TELESCOPE & HARPOON
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			require('plugins.telescope')
		end,
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require('plugins.harpoon')
		end,
	},

	-- OTHER PLUGINS
	{
		"mbbill/undotree",
		keys = {
			{ "<F5>", "<cmd>UndotreeToggle<CR>", desc = "Toggle Undotree" },
		},
	},
	{
		"kdheepak/lazygit.nvim",
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<CR>", desc = "Open LazyGit" },
		},
	},
	"skywind3000/asyncrun.vim",
	"skywind3000/asynctasks.vim",
	"nvim-tree/nvim-web-devicons",
})
