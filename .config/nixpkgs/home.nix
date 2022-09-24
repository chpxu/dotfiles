{
  config,
  pkgs,
  lib,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = pkg: true;
  # home.username = "chunix";
  # home.homeDirectory = "/home/chunix";
  imports = [
    ./modules/default.nix
  ];
  # Install home packages
  home.packages = with pkgs; [
    # Reserve this for programs which do not have config options n home-manager
    # Audio
    pipewire
    wireplumber
    alsa-utils
    (pkgs.wayfire.overrideAttrs (oldAttrs: rec {
      version = "0.7.4";
      src = fetchurl {
        url = "https://github.com/WayfireWM/wayfire/releases/download/v${version}/wayfire-${version}.tar.xz";
        sha256 = "89e375f7320d7bd4023d9f9499f979ee7209594afbb5aa0cfd897934a7f0514d";
      };
    }))
    wcm
    wf-config
    bemenu
    cliphist
    grim
    slurp
    swayidle
    kanshi
    wl-clipboard
    wofi
    imv
    zsh-powerlevel10k
    # applications
    # firefox-wayland
    thunderbird-wayland
    (pkgs.discord-canary.overrideAttrs (oldAttrs: rec {
      version = "0.0.139";
      src = fetchurl {
        url = "https://dl-canary.discordapp.net/apps/linux/${version}/discord-canary-${version}.tar.gz";
        sha256 = "sha256-/PfO0TWRxMrK+V1XkYmdaXQ6SfyJNBFETaR9oV90itI=";
      };
    }))
    betterdiscordctl
    inkscape-with-extensions
    gimp-with-plugins
    neofetch
    bitwarden
    teams
    libreoffice-fresh
    # OneDrive
    onedrive
    # Virtual Keyboard
    (pkgs.wvkbd.overrideAttrs (oldAttrs: rec {
      src = fetchFromGitHub {
        owner = "chpxu";
        repo = "wvkbd";
        rev = "6ee1764535a06b9888242ad4a9c42a7ac9821791";
        sha256 = "TWd/CECWxZJ0WeFVjeuHWAq9fGKGOd6MLpjvzOpKGOo=";
      };
    }))

    unzip
    stress-ng

    # Utils
    xdg-utils
    yt-dlp
    #ffmpeg_5-full
    jmtpfs
    # Python
    python310Full
    # chromium
    # === Audio ===
    easyeffects
    lsp-plugins
    calf
    ### Custom Packages or Derivations or Combinations etc
    # TeXLive
    texlive.combined.scheme-full
    #xournalpp-nord
    (pkgs.xournalpp.overrideAttrs (oldAttrs: rec {
      src = fetchFromGitHub {
        owner = "chpxu";
        repo = "xournalpp";
        rev = "8f44c87edf5367efc1f86f0ac8ab7234e98db214";
        sha256 = "wSP5BwluLDtScuK1/CuJUWbdTSJErNXUnlsECl7xbtU=";
      };
    }))

    # game again
    # bottles
  ];

  # GTK themes
  gtk = rec {
    enable = true;
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
    iconTheme = {
      name = "Nordzy";
      package = pkgs.nordzy-icon-theme;
    };
    # cursorTheme = {
    #   name = "Nordzy-cursors";
    #   package = pkgs.nordzy-cursor-theme;
    # };
    gtk2 = {
      configLocation = "${config.home.homeDirectory}/.gtkrc-2.0";
    };
  };
  dconf = {
    settings = {
      "org/gnome/desktop/interface" = {
        gtk-theme = "${config.gtk.theme.name}";
        # cursor-theme = "${config.gtk.cursorTheme.name}";
      };
      "org/gnome/desktop/wm/preferences" = {
        theme = "${config.gtk.theme.name}";
      };
    };
  };
  # home.stateVersion = "22.05";
  programs.home-manager.enable = true;
}
