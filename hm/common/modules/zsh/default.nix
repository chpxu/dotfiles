{
  pkgs,
  config,
  lib,
  options,
  specialArgs,
  modulesPath,
  ...
}: {
  programs.zsh = {
    # dotDir = ".config/zsh";
    history = {
      path = "${config.xdg.configHome}/zsh/zsh_history";
    };
    shellAliases = {
      odsu = "onedrive --synchronize --upload-only";
      ods = "onedrive --synchronize --no-remote-delete";
      teams = "teams --enable-features=UseOzonePlatform --ozone-platform=wayland";
    };
    enableSyntaxHighlighting = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    initExtra = ''
      eval "$(starship init zsh)"
    '';
    oh-my-zsh = {
      enable = true;
      # theme = "agnoster";
      plugins = [
        "git"
        "gh"
        # "npm"
        # "zsh-interactive-cd"
      ];
    };
  };
}
