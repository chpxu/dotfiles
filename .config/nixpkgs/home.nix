{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  discordver = "0.0.140";
in {
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = pkg: true;
  manual.manpages.enable = false;
  # Install ohome packages

  home.packages = with pkgs;
    [
      dolphin
      thunderbird-wayland
      (pkgs.discord-canary.overrideAttrs (oldAttrs: rec {
        version = discordver;
        src = fetchurl {
          url = "https://dl-canary.discordapp.net/apps/linux/${version}/discord-canary-${version}.tar.gz";
          sha256 = "sha256-AEbjkAMeOJ48RVgbVj35Rp26klCsCsDCX+VD5u1xCM0=";
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

      # Utils
      xdg-utils
      yt-dlp
      #ffmpeg_5-full
      jmtpfs

      # TeXLive
      texlive.combined.scheme-full
      ltex-ls
      tikzit

      (pkgs.xournalpp.overrideAttrs (oldAttrs: rec {
        src = fetchFromGitHub {
          owner = "chpxu";
          repo = "xournalpp";
          rev = "8f44c87edf5367efc1f86f0ac8ab7234e98db214";
          sha256 = "sha256-wSP5BwluLDtScuK1/CuJUWbdTSJErNXUnlsECl7xbtU=";
        };
      }))
      # xournalpp
      rnote
      lammps
      # opentabletdriver
    ]
    ++ [
      pkgs.gamemode
      # inputs.nix-gaming.packages.${pkgs.system}.osu-stable
      inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
    ];
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
  };
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
        # cursor-theme = "${config.gtk.cursorTheme.name}";
      };
      "org/gnome/desktop/wm/preferences" = {
        theme = "${config.gtk.theme.name}";
      };
    };
  };
  programs.home-manager.enable = true;
}
