{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraLuaConfig = ''
      vim.g.mapleader = " "

      require('config.lazy') 

      require('config.options')
      require('config.mappings')
      require('config.autocmds')
    '';


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
  # create the config files that we reference
  xdg.configFile = {
    "nvim/lua/config" = {
      source = ./config;
      recursive = true;
    };
    "nvim/lua/plugins" = {
      source = ./plugins;
      recursive = true;
    };
  };
}


