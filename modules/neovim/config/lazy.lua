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
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "auto"
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local function harpoon_indicator()
				for index, item in ipairs(require("harpoon"):list().items) do
					if item.value == vim.api.nvim_buf_get_name(0) then
						return "󰛢" .. index
					end
				end
				return ""
			end
			require("lualine").setup({
				options = {
					theme = "auto",
				},
				sections = {
					lualine_c = {
						"filename",
						harpoon_indicator,
					},
				},
			})
		end,
	},
	{
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			require("ibl").setup()
		end,
	},
	-- {
	-- 	"stevearc/dressing.nvim",
	-- 	config = function()
	-- 		require("dressing").setup()
	-- 	end,
	-- },
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Keymaps (which-key)"
			}
		}
	},
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
			})
		end
	},
	{
		"windwp/nvim-autopairs",
		opts = {
			fast_wrap = {},
			disable_filetype = { "TelescopePrompt", "vim" },
		},
		config = function(_, opts)
			require("nvim-autopairs").setup(opts)

			-- setup cmp for autopairs
			local cmp_autopairs = require "nvim-autopairs.completion.cmp"
			require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
	{
		'nvim-mini/mini.nvim',
		version = false,
		config = function()
			require('mini.comment').setup()
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
		'mrcjkb/rustaceanvim',
		version = '^6',
		lazy = false, -- This plugin is already lazy
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
			"gbrlsnchs/telescope-lsp-handlers.nvim",
		},
		config = function()
			require('plugins.telescope')
		end,
	},
	-- {
	-- 	"ThePrimeagen/harpoon",
	-- 	branch = "harpoon2",
	-- 	dependencies = { "nvim-lua/plenary.nvim" },
	-- 	config = function()
	-- 		require('plugins.harpoon')
	-- 	end,
	-- },
	{
		'stevearc/quicker.nvim',
		ft = "qf",
		---@module "quicker"
		---@type quicker.SetupOptions
		opts = {},
		config = function()
			require("quicker").setup()
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
