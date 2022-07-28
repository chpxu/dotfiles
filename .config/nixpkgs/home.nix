{ config, pkgs, ... }:
let
  unstable = import <nixpkgs-unstable> { config = { allowUnfree = true; }; };
in
{ 
  home.username = "chunix";
  home.homeDirectory = "/home/chunix";
  
  # Install home packages
  home.packages = [
    # wayfire and making desktop
    pkgs.wayfire
    pkgs.wcm
    pkgs.wf-config
    unstable.waybar
    unstable.bemenu
    unstable.cliphist
    unstable.mako
    unstable.grim
    unstable.slurp
    unstable.swaylock-effects
    unstable.swayidle
    unstable.kanshi
    unstable.wl-clipboard
    unstable.wlogout
    # viewers
    unstable.zathura
    unstable.mpv
    unstable.imv
    # applications
    unstable.firefox-wayland
    unstable.thunderbird-wayland
    unstable.discord-canary
    unstable.betterdiscordctl
    unstable.vscode-with-extensions
    unstable.inkscape-with-extensions
    unstable.gimp-with-plugins
    unstable.alacritty
    unstable.neofetch
    unstable.xournalpp
    # Git and GitHub
    unstable.git
    unstable.gh
    # TeXLive
    unstable.texlive.combined.scheme-basic
    # OneDrive
    unstable.onedrive
    unstable.wofi
    # Maliit for Touch keyboard (we love touch friendliness)
  ];
  # GTK themes
  gtk = {
    enable = true;
    theme = {
      name = "Nordic";
      package = unstable.nordic;
    };
    iconTheme = {
      name = "Nordzy";
      package = unstable.nordzy-icon-theme;
    };
    cursorTheme = {
      name = "Nordzy-cursors";
      package = unstable.nordzy-cursor-theme;
    };
  };
  # Modify .desktop files for icons because they don't change automaticaly??
  xdg.desktopEntries = {
    firefox = {
      exec = "firefox %u";
      name = "Firefox";
      genericName = "Web Browser";
      icon = "/nix/store/2zylfzc7g8fwwnqvryi55s151k4580f3-nordzy-icon-theme-1.5/share/icons/Nordzy/apps/scalable/firefox.svg";
      terminal = false;
      type = "Application";
      categories = [ "Network" "WebBrowser" ];
    };
  };
  dconf = { enable = true; };

  home.stateVersion = "22.05";
  programs.home-manager.enable = true;
}
