{config, ...}: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    #autosuggestion.highlight="fg=#5e81ac,bold";
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    syntaxHighlighting.highlighters = ["brackets" "line"];
    autocd = true;
    dirHashes = {
      docs = "${config.home.homeDirectory}/Documents";
      vids = "${config.home.homeDirectory}/Videos";
      dl = "${config.home.homeDirectory}/Downloads";
    };

    initContent = ''
      eval "$(direnv hook zsh)"
      export GRIM_DEFAULT_DIR=$XDG_SCREENSHOTS_DIR
      zstyle ':completion:*' menu select
    '';
    oh-my-zsh.enable = false;
    shellAliases = {
      dotfiles = ''
        if [ -d "$HOME/dotfiles" ]; then
            cd $HOME/dotfiles
        else
            cd $HOME/git_projects/dotfiles
        fi'';
      switch = ''sudo nixos-rebuild switch --flake .#$(hostname) --impure'';
      upgrade = ''dotfiles; nix flake update'';
    };
  };
}
