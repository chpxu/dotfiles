{
  config,
  pkgs,
  lib,
  ...
}: let
  gitProjConfig = "git_projects/dotfiles/.config";
in {
  xdg = {
    enable = true;
    # cacheHome = ~/.cache;
    # dataHome = ~/.local/share;
    # stateHome = ~/.local/state;
    systemDirs = {
      config = ["/etc/xdg"];
      data = ["/usr/share" "/usr/local/share"];
    };
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "$HOME";
      documents = "$HOME/Documents";
      download = "$HOME/Downloads";
      music = "$HOME/Music";
      pictures = "$HOME/Pictures";
      videos = "$HOME/Videos";
      templates = "$HOME";
      publicShare = "$HOME";
      extraConfig = {
        XDG_MISC_DIR = "$HOME/Misc";
      };
    };
    mime.enable = true;
    mimeApps = {
      enable = true;
      # TO-DO: Mime associations where necessary
    };
  };
}
