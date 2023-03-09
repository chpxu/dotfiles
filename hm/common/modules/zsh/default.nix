{...}: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    autocd = true;
    initExtra = ''
      eval "$(direnv hook zsh)"
    '';
    oh-my-zsh.enable = true;
  };
}
