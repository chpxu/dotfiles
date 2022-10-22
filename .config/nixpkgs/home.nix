{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = pkg: true;
  manual.manpages.enable = false;
  # Install ohome packages
  home.packages = with pkgs;
    [
    	dolphin
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

      # Utils
      xdg-utils
      yt-dlp
      #ffmpeg_5-full
      jmtpfs

      # chromium
      # === Audio ===
      # easyeffects
      # lsp-plugins
      # calf
      ### Custom Packages or Derivations or Combinations etc
      # TeXLive
      texlive.combined.scheme-full
      ltex-ls
      tikzit

      #(pkgs.xournalpp.overrideAttrs (oldAttrs: rec {
      #  src = fetchFromGitHub {
      #    owner = "chpxu";
      #    repo = "xournalpp1";
      #    rev = "3b7a80b6e2f516befa8a06ef281cee47bdecdcf9";
      #    sha256 = "sha256-wfR0SqjTTZTta2VBQ9vRWyCaNFTzC0KaFpInrKn/FBU=";
      #  };
      #}))
      xournalpp
      lammps
      # opentabletdriver
    ]
    ++ [
      pkgs.gamemode
      inputs.nix-gaming.packages.${pkgs.system}.osu-stable
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
