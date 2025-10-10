{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraLuaConfig = ''
      vim.g.mapleader = " "
      vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"


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
	  -- TREESITTER
	  {
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
		  ${builtins.readFile ./plugins/treesitter.lua}
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
		  ${builtins.readFile ./plugins/lspconfig.lua}
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
		  ${builtins.readFile ./plugins/conform.lua}
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
		  ${builtins.readFile ./plugins/cmp.lua}
		end,
	  },

	  -- FILE EXPLORER
	  {
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
		  ${builtins.readFile ./plugins/oil.lua}
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
		  ${builtins.readFile ./plugins/telescope.lua}
		end,
	  },
	  {
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
		  ${builtins.readFile ./plugins/harpoon.lua}
		end,
	  },

	  -- OTHER PLUGINS
	  "mbbill/undotree",
	  "kdheepak/lazygit.nvim",
	  "skywind3000/asyncrun.vim",
	  "skywind3000/asynctasks.vim",
	  "nvim-tree/nvim-web-devicons",
	})
      
      ${builtins.readFile ./config/options.lua}
      ${builtins.readFile ./config/mappings.lua}
      ${builtins.readFile ./config/autocmds.lua}
    '';

    # Load all plugins and their configs
    plugins = import ./plugins.nix { inherit pkgs; };

    # extraPackages = with pkgs; [
    #   # LSP servers
    #   clang-tools
    #   lua-language-server
    #   bash-language-server
    #   yaml-language-server
    #   marksman
    #   nodePackages.vscode-langservers-extracted # json, css, html
    #
    #   # Formatters
    #   stylua
    #   ktlint
    #
    #   # Tools
    #   ripgrep
    #   fd
    #   lazygit
    # ];
  };
}


