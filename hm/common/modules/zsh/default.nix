{...}: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    #autosuggestion.highlight="fg=#5e81ac,bold";
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    syntaxHighlighting.highlighters = ["brackets" "line"];
    autocd = true;
    initExtra = ''
      eval "$(direnv hook zsh)"
      export GRIM_DEFAULT_DIR=$HOME/Screenshots
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
    };
  };
}
