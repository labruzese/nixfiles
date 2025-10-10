{ pkgs }:

with pkgs.vimPlugins; [
  # TREESITTER
  {
    plugin = nvim-treesitter.withAllGrammars;
    type = "lua";
    config = builtins.readFile ./plugins/treesitter.lua;
  }
  {
    plugin = nvim-treesitter-context;
    type = "lua";
    config = ''
      require('treesitter-context').setup({})
    '';
  }

  # LSP
  {
    plugin = nvim-lspconfig;
    type = "lua";
    config = builtins.readFile ./plugins/lspconfig.lua;
  }
  {
    plugin = mason-nvim;
    type = "lua";
    config = ''
      require('mason').setup()
    '';
  }
  {
    plugin = mason-lspconfig-nvim;
    type = "lua";
    config = ''
      require('mason-lspconfig').setup({
        automatic_installation = true,
      })
    '';
  }
  {
    plugin = conform-nvim;
    type = "lua";
    config = builtins.readFile ./plugins/conform.lua;
  }

  # AUTOCOMPLETE
  {
    plugin = nvim-cmp;
    type = "lua";
    config = builtins.readFile ./plugins/cmp.lua;
  }
  cmp-nvim-lsp
  cmp-path
  cmp-buffer
  luasnip
  cmp_luasnip

  {
    plugin = oil-nvim;
    type = "lua";
    config = builtins.readFile ./plugins/oil.lua;
  }

  # FILE FZF
  {
    plugin = telescope-nvim;
    type = "lua";
    config = builtins.readFile ./plugins/telescope.lua;
  }
  telescope-fzf-native-nvim
  plenary-nvim
  {
    plugin = harpoon2;
    type = "lua";
    config = builtins.readFile ./plugins/harpoon.lua;
  }

  undotree

  # for async binding of clipboard manager
  asyncrun-vim
  asynctasks-vim

  nvim-web-devicons
]
