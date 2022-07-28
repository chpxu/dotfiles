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
    unstable.nwg-launchers
    unstable.mako
    unstable.grim
    unstable.slurp
    unstable.swaylock-effects
    unstable.swayidle
    unstable.kanshi
    unstable.wl-clipboard
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
    # Git and GitHub
    unstable.git
    unstable.gh
    # TeXLive
    unstable.texlive.combined.scheme-basic
    # OneDrive
    unstable.onedrive
    
    #unstable.xdg-utils
    #unstable.libsecret
    #unstable.libgnome-keyring
    #unstable.gnome.gnome-keyring
  ];
  #xdg = {
  #  portal = {
  #    enable = true;
  #    wlr.enable = true;
  #  };
  #};
  # GTK themes
  gtk = {
    enable = true;
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
    iconTheme = {
      name = "zafiro-icons";
      package = pkgs.zafiro-icons;
    };
  };

  dconf = {
    enable = true;
    settings = {
      "org.gnome.desktop.interface" = {
        "gtk-theme" = "Nordic";
        "icon-theme" = "zafiro-icons";
      };
      "org.gnome.desktop.wm.preferences" = {
        "theme" = "Nordic";
      };
    };
  };
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;
}
