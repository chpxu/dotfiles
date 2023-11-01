{
  config,
  pkgs,
  inputs,
  outputs,
  ...
}: {
  imports = [
    ./packages
    ./modules
  ];
  gtk = {
    enable = true;
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
    iconTheme = {
      name = "Nordzy";
      package = pkgs.nordzy-icon-theme;
    };
    cursorTheme = {
      name = "Nordzy-cursors";
      package = pkgs.nordzy-cursor-theme;
      size = 32;
    };
    gtk2 = {
      configLocation = "${config.home.homeDirectory}/.gtkrc-2.0";
    };
  };
  dconf = {
    settings = {
      "org/gnome/desktop/interface" = {
        gtk-theme = "${config.gtk.theme.name}";
        cursor-theme = "${config.gtk.cursorTheme.name}";
      };
      "org/gnome/desktop/wm/preferences" = {
        theme = "${config.gtk.theme.name}";
      };
    };
  };
  home.packages = with pkgs; [
    # other applications may be in overlays
    #clisp
    discord-canary
    bitwarden
    waybar
    hyprpaper
    wvkbd
    logseq
    zotero
    #rpi-imagerstable
  ];
  programs.home-manager.enable = true;
  home.stateVersion = "22.11";
}
