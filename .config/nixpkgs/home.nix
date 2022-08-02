{ config, pkgs, ... }:
let
  unstable = import <nixpkgs-unstable> { config = { allowUnfree = true; }; };
  xournalpp-nord = import ./xournalpp/xournalpp-nordDark.nix;
  myTexInstall = (unstable.texlive.combine {
      inherit (unstable.texlive) scheme-full;
    });
  
in
{ 
  home.username = "chunix";
  home.homeDirectory = "/home/chunix";
  
  # Install home packages
  home.packages = [
    unstable.libdrm
    unstable.intel-ocl
    unstable.vaapiIntel
    unstable.intel-media-driver
    unstable.intel-compute-runtime
    unstable.libGLU
    unstable.libglvnd
    # Audio
    unstable.pipewire
    unstable.wireplumber
    unstable.alsa-utils
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
    unstable.inkscape-with-extensions
    unstable.gimp-with-plugins
    unstable.kitty
    unstable.neofetch
 
    # Git and GitHub
    unstable.git
    unstable.gh
    
    # OneDrive
    unstable.onedrive
    
    # Virtual Keyboard
    unstable.wvkbd
   
    #unstable.wgcf
    unstable.unzip

    # Utils
    unstable.linux-pam
    unstable.dconf
    unstable.tlp
    unstable.xdg-utils
   
    # Game
    unstable.osu-lazer
    #unstable.lutris
    ### Custom Packages or Derivations or Combinations etc
    # TeXLive
    myTexInstall
    xournalpp-nord    
  ];
  imports = [
    # Import my vscode configuration
    ./vscode.nix
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
    shellAliases = {
      od = "onedrive --synchronize --upload-only && onedrive --synchronize --no-remote-delete";
    };
    #loginShellInit = "wayfire";
  }; 
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;
}
