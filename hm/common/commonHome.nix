{
  config,
  pkgs,
  outputs,
  ...
}: {
  imports = [
    ./packages
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
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };
  nixpkgs = {
    overlays = with outputs.overlays; [
      # clisp
      #xournalpp
      waybar
      #discord-canary
      wvkbd
      # rnote
      # bitwarden
    ];
  };
  home.packages = with pkgs; [
    # other applications may be in overlays
    #clisp
    discord-canary
    # bitwarden
    waybar
    hyprpaper
    wvkbd
    x2goclient
    #zotero
    #rpi-imager
  ];
  manual.manpages.enable = false;
  programs.home-manager.enable = true;
}
