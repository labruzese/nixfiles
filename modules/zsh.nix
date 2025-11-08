{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = false;
    syntaxHighlighting.enable = true;

    dotDir = ".config/zsh";

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    # Vi mode settings
    defaultKeymap = "viins";

    # Oh My Zsh integration
    oh-my-zsh = {
      enable = true;
      theme = "clean";

      plugins = [
        "archlinux"
        "git"
        "vi-mode"
        "extract"
      ];

      extraConfig = ''
        HYPHEN_INSENSITIVE="true"
      '';
    };

    initExtra = ''
      # Vi mode configuration
      KEYTIMEOUT=15
      VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
      MODE_INDICATOR="%F{blue} %f"
      INSERT_MODE_INDICATOR="%F{green} %f"
      VI_MODE_CURSOR_VISUAL=0
      
      # Add vi mode indicator to prompt
      PROMPT="\$(vi_mode_prompt_info)$PROMPT"
      
      # WezTerm shell integration
      if [[ "$TERM_PROGRAM" == "WezTerm" ]]; then
        source ~/.config/wezterm/shell-integration/wezterm.sh
      fi
      
      # Pyenv initialization
      export PYENV_ROOT="$HOME/.pyenv"
      [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
      eval "$(pyenv init -)"
      
      # GHCup environment
      [ -f "/home/sky/.ghcup/env" ] && . "/home/sky/.ghcup/env"
      
      # Zoxide initialization
      eval "$(zoxide init --cmd cd zsh)"
      
      # Opam configuration
      [[ ! -r '/home/sky/.opam/opam-init/init.zsh' ]] || source '/home/sky/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
    '';

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      TERM = "wezterm";
      MANPAGER = "nvim +Man!";
    };

    shellAliases = {
      ls = "exa --icons";
      trash = "gio trash";
      copy = "wl-copy";
    };

    sessionPath = [
      "$HOME/scripts"
      "$HOME/.cargo/bin"
    ];
  };

  home.packages = with pkgs; [
    exa
    zoxide
    neovim
    wezterm
    wl-clipboard
  ];
}
