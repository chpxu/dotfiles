{den, ...}: {
  # user aspect
  den.ctx.user.includes = [den._.mutual-provider];
  den.aspects.chunix = {
    includes = [
      den.provides.define-user
      den.provides.primary-user
      (den.provides.user-shell "zsh")
      den.aspects.hyprland
    ];

    homeManager = {pkgs, ...}: {
      home.packages = [pkgs.htop];
    };

    # user can provide NixOS configurations
    # to any host it is included on
    provides.to-hosts = {host, ...}: {
      nixos.programs.nh.enable = true;
    };
  };
}
