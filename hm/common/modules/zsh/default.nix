{...}: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    initExtra = ''
      . "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh"
      eval "$(direnv hook zsh)"
      export GRIM_DEFAULT_DIR=$HOME/Screenshots
    '';
    oh-my-zsh.enable = true;
  };
}
