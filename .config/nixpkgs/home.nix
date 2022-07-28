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
    unstable.github-desktop
    # TeXLive
    unstable.texlive.combined.scheme-basic
    # OneDrive
    unstable.onedrive
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
  
  # Config files
  xdg.configFile = {
    alacritty = {
      source = /home/chunix/.config/alacritty;
      recursive = true;
    };
    BetterDiscord = {
      source = /home/chunix/.config/BetterDiscord;
      recursive = true;
    };
    Code = {
      source = /home/chunix/.config/Code;
      recursive = true;
    };
    GIMP = {
      source = /home/chunix/.config/GIMP/2.10;
      recursive = true;
    };
    "GitHub Desktop" = {
      source = "/home/chunix/.config/GitHub Desktop";
      recursive = true;
    };
    Inkscape = {
      source = /home/chunix/.config/inkscape;
      recursive = true;
    };
    kanshi = {
      source = /home/chunix/.config/kanshi;
      recursive = true;
    };
    light = {
      source = /home/chunix/.config/light;
      recursive = true;
    };
    mako = {
      source = /home/chunix/.config/mako;
      recursive = true;
    };
    mpv = {
      source = /home/chunix/.config/mpv;
      recursive = true;
    };
    nano = {
      source = /home/chunix/.config/nano;
      recursive = true;
    };
    neofetch = {
      source = /home/chunix/.config/neofetch;
      recursive = true;
    };
    nwg-launchers = {
      source = /home/chunix/.config/nwg-launchers;
      recursive = true;
    };
  };
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;
}
