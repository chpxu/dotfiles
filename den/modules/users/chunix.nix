{ den, ... }:
{

  den.aspects.chunix = {
    includes = [
      den.provides.primary-user
      den._.mutual-provider
      (den.provides.user-shell "zsh")
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
      den.aspects.wpaperd
      den.aspects.git

      den.aspects.sound._.easyeffects
      den.aspects.zathura
      den.aspects.dev._.neovim
      den.aspects.dev._.vscode
    ];

    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.fresh-editor ];
        programs.git.settings = {
          user = {
            name = "chpxu";
            email = "dev.chpxu@outlook.com";
          };
        };
      };

    # user can provide NixOS configurations
    # to any host it is included on
    provides.to-hosts =
      { host, ... }:
      {
        nixos = {
          programs.nh = {
            enable = true;
            clean.enable = true;
            clean.extraArgs = "--keep-since 30d --keep 3";
            flake = "$(dotfiles)";
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
