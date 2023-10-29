{...}: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    initExtra = ''
      eval "$(direnv hook zsh)"
      export GRIM_DEFAULT_DIR=$HOME/Screenshots
    '';
    oh-my-zsh.enable = true;
  };
}
