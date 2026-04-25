{ den, inputs, ... }:
{

  den.aspects.chunix = {
    includes = [
      den.provides.primary-user
      den._.mutual-provider
      (den.provides.user-shell "zsh")
      den.aspects.hardware._.tablet
      den.aspects.chunix-xdg
      den.aspects.hyprland
      den.aspects.starship
      den.aspects.zsh
      den.aspects.kitty
      den.aspects.mako
      den.aspects.rofi
      den.aspects.direnv
      den.aspects.jq
      den.aspects.waybar
      den.aspects.sway
      den.aspects.wpaperd
      den.aspects.yazi

      den.aspects.sound._.pipewire
      den.aspects.sound._.easyeffects
      den.aspects.zathura
      den.aspects.dev
      den.aspects.dev._.git
      den.aspects.dev._.helix
      den.aspects.dev._.vscode
      den.aspects.productivity
      den.aspects.mpv
      den.aspects.syncthing
      den.aspects.art
      den.aspects.gaming
      den.aspects.gaming._.minecraft
      den.aspects.gaming._.osu
      den.aspects.browsers._.firefox

    ];

    homeManager =
      { config, pkgs, ... }:
      let
        materialPkgs = inputs.materials.packages.${pkgs.stdenv.hostPlatform.system};
      in
      {
        home.packages = with pkgs; [
          grim
          slurp
          swayidle
          wl-clipboard
          imv
          xdg-utils
          unzip
          jmtpfs
          dragon-drop
          materialPkgs.VESTA
        ];
        programs.git.settings = {
          user = {
            name = "chpxu";
            email = "dev.chpxu@outlook.com";
          };
        };
        gtk = {
          enable = true;
          gtk4.theme = config.gtk.theme;
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
      };

    # user can provide NixOS configurations
    # to any host it is included on
    provides.to-hosts = _: {
      nixos =
        { pkgs, ... }:
        {
          programs.nh = {
            enable = true;
            clean.enable = true;
            clean.extraArgs = "--keep-since 30d --keep 3";
          };
          environment.systemPackages = with pkgs; [
            openconnect
            gpclient
          ];
          environment.sessionVariables = {
            LIBSEAT_BACKEND = "logind";
            XCURSOR_SIZE = "32";
          };
          programs = {
            dconf.enable = true;
            mtr.enable = true;
            gnupg.agent = {
              enable = true;
              enableSSHSupport = true;
            };
          };

          gtk.iconCache.enable = true;

          qt = {
            enable = true;
            style = "gtk2";
            platformTheme = "gtk2";
          };

        };

    };
    user = _: {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "audio"
        "video"
        "input"
        "disk"
        "networkmanager"
        "libvirt"
      ];

      hashedPassword = "$y$j9T$ZrsmB74qJZPIGnug4S9oK/$8oGAGKC3TYuo0nfouU9gzoIEjSS5c6rVtRcGye0QDf7";
      description = "chunix";
    };
  };
}
