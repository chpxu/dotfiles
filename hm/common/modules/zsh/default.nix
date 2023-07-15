{...}: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    initExtra = ''
      eval "$(direnv hook zsh)"
    '';
    oh-my-zsh.enable = true;
  };
}
