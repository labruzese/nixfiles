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


