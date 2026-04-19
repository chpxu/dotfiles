_: {
  den.aspects.zsh = {
    homeManager =
      { config, ... }:
      {
        programs.zsh = {
          enable = true;
          autosuggestion.enable = true;
          autosuggestion.highlight = "fg=#5e81ac,bold";
          dotDir = "${config.xdg.configHome}/zsh";
          enableCompletion = true;
          syntaxHighlighting.enable = true;
          syntaxHighlighting.highlighters = [
            "brackets"
            "line"
          ];
          autocd = true;
          dirHashes = {
            doc = "${config.home.homeDirectory}/Documents";
            vid = "${config.home.homeDirectory}/Videos";
            dl = "${config.home.homeDirectory}/Downloads";
          };

          initContent = ''
            eval "$(direnv hook zsh)"
            export GRIM_DEFAULT_DIR=$XDG_SCREENSHOTS_DIR
            zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
            zstyle ':completion:*' menu select
            autoload -U colors && colors
            [ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"
          '';
          oh-my-zsh.enable = false;
          prezto = {
            enable = false;
            editor = {
              dotExpansion = true;
              keymap = "vi";
            };
          };
          shellAliases = {
            dotfiles = ''
              export DOTFILESDIR=$(find "$HOME" -maxdepth 2 -type d -name "dotfiles" -print -quit 2>/dev/null)
              cd "$DOTFILESDIR"
            '';
            switch = "sudo nixos-rebuild switch --flake .#$(hostname)";
            alldeps = "dotfiles; nix flake update";
            updep = "dotfiles; nix flake update $1";
          };
        };
      };
  };
}
