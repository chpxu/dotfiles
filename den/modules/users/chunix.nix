{ den, ... }:
{

  den.aspects.chunix = den.lib.parametric {
    includes = [
      den.provides.define-user
      den.provides.primary-user
      (den.provides.user-shell "zsh")
      den.aspects.hyprland
      den._.mutual-provider
      den.aspects.starship
    ];

    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.fresh-editor ];
      };

    # user can provide NixOS configurations
    # to any host it is included on
    provides.to-hosts =
      { host, ... }:
      {
        nixos.programs.nh.enable = true;
      };
  };
}
