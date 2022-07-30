{ config, pkgs, ... }:
let
  unstable = import <nixpkgs-unstable> { config = { allowUnfree = true; }; };
  xournalpp-nord = import ./xournalpp/xournalpp-nordDark.nix;
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
    unstable.wofi
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
    #unstable.xournalpp
    # Git and GitHub
    unstable.git
    unstable.gh
    # TeXLive
    unstable.texlive.combined.scheme-basic
    # OneDrive
    unstable.onedrive
    
    # Virtual Keyboard
    unstable.wvkbd
    #pkgs.gdb
    unstable.wgcf
    unstable.unzip
    xournalpp-nord
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
  programs.zsh = {
    loginExtra = "betterdiscordctl --d-modules ~/.config/discordcanary/0.0.136/modules/ install";
  };
  # Install custom Xournal++ Version - this has the Nord theme plus modified Xournal++ CSS file.
  # xournalpp = unstable.xournalpp.overrideAttrs (finalAttrs: previousAttrs: {
  #   src = github:chpxu/xournalpp-nord/master/dir=xournalpp-1.1.1;
  #   enableParallelBuilding = true;
  #   buildInputs = with unstable; [ 
  #     cmake
  #     glib
  #     pkg-config
  #     gtk3
  #     gettext
  #     wrapGAppsHook
  #     librsvg
  #     libsndfile
  #     libxml2
  #     libzip
  #     pcre
  #     poppler
  #     portaudio
  #     zlib
  #   ];
  # });

  home.stateVersion = "22.05";
  programs.home-manager.enable = true;
}
