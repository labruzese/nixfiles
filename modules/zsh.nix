{ config, pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = false;
    syntaxHighlighting.enable = true;

    profileExtra = ''
      if uwsm check may-start 1>/dev/null && [ -z "''${SSH_CONNECTION}" ]; then
      exec uwsm start hyprland.desktop
      fi
    '';

    dotDir = "${config.xdg.configHome}/zsh";

    history = {
      size = 10000;
    };

    shellAliases = {
      ls = "exa --icons";
      trash = "gio trash";
      copy = "wl-copy";
    };

    # Vi mode settings
    defaultKeymap = "viins";

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      TERM = "wezterm";
      MANPAGER = "nvim +Man!";
    };

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
        # Vi mode configuration
        VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
        KEYTIMEOUT=15
        MODE_INDICATOR="%F{blue} %f"
        INSERT_MODE_INDICATOR="%F{green} %f"
        VI_MODE_CURSOR_VISUAL=0

        HYPHEN_INSENSITIVE="true"
      '';
    };

    initContent =
      let
        enviornments = lib.mkBefore ''
          # path
          export PATH="$HOME/scripts:$HOME/.cargo/bin:$PATH"

          # pyenv
          export PYENV_ROOT="$HOME/.pyenv"
          [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
          eval "$(pyenv init -)"

          # GHCup environment
          [ -f "/home/sky/.ghcup/env" ] && . "/home/sky/.ghcup/env"

          # opam 
          [[ ! -r '/home/sky/.opam/opam-init/init.zsh' ]] || source '/home/sky/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
        '';
        configs = lib.mkDefault ''
          # Zoxide initialization
          eval "$(zoxide init --cmd cd zsh)"

          # WezTerm shell integration
          if [[ "$TERM_PROGRAM" == "WezTerm" ]]; then
          source ~/.config/wezterm/shell-integration/wezterm.sh
          fi
        '';
        overrides = lib.mkAfter ''
          if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="white"; fi

          PROMPT='%{$fg[$NCOLOR]%}%B%n@%m%b%{$reset_color%}:%{$fg[blue]%}%B%c/%b%{$reset_color%} $(git_prompt_info)%(!.#.$) '
          RPROMPT='[%*]'

          # Add vi mode indicator to prompt
          PROMPT="\$(vi_mode_prompt_info)$PROMPT"
        '';
      in
      lib.mkMerge [ enviornments configs overrides ];
  };

  home.packages = with pkgs; [
    exa
    zoxide
    neovim
    wezterm
    wl-clipboard
  ];
}
