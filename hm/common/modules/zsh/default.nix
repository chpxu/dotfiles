{...}: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    initExtra = ''
      eval "$(direnv hook zsh)"
      export GRIM_DEFAULT_DIR=$HOME/Screenshots
    '';
    oh-my-zsh.enable = false;
    shellAliases = {
      dotfiles = ''
        if [ -d "$HOME/dotfiles" ]; then
            cd $HOME/dotfiles
        else
            cd $HOME/git_projects/dotfiles
        fi'';
    };
  };
}
