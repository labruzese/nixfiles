{ config, pkgs, lib, ... }: {
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd" "cd" ];
  };

  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = false;
    syntaxHighlighting.enable = true;

    profileExtra = ''
      if [ -z "''${SSH_CONNECTION}" ] && \
         [ "$(tty)" = "/dev/tty1" ] && \
         [ -z "''${DISPLAY}" ] && \
         [ -z "''${WAYLAND_DISPLAY}" ]; then
        exec start-hyprland
      fi
    '';

    dotDir = "${config.xdg.configHome}/zsh";

    history = {
      path = "$HOME/.zsh_history";
      size = 10000;
    };

    shellAliases = {
      ls = "exa --icons";
      trash = "gio trash";
      copy = "wl-copy";
      vim = "nvim";
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

      plugins = [ "archlinux" "git" "vi-mode" "extract" ];

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

    initContent = let
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
      configs = lib.mkDefault "";
      overrides = lib.mkAfter ''
        if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="white"; fi

        PROMPT='%{$fg[$NCOLOR]%}%B%n@%m%b%{$reset_color%}:%{$fg[blue]%}%B%c/%b%{$reset_color%} $(git_prompt_info)%(!.#.$) '
		# RPROMPT='[%*]'

        # Add vi mode indicator to prompt
		# PROMPT="\$(vi_mode_prompt_info)$PROMPT"
		PROMPT='%(?.%f.%F{red}<%?>%f)'"$PROMPT"
      '';
    in lib.mkMerge [ enviornments configs overrides ];
  };

  home.packages = with pkgs;
    [
      # exa
      # zoxide
      # neovim
      # wezterm
      # wl-clipboard
    ];
}
