_: {
  den.aspects.wallpaper = {

    homeManager =
      { config, ... }:
      {
        home.file = {
          "wallpaper1" = {
            source = config.lib.file.mkOutOfStoreSymlink (./. + "/john-towner1.jpg");
            target = "Pictures/Wallpapers/john-towner1.jpg";
            force = true;
          };
          "wallpaper2" = {
            source = config.lib.file.mkOutOfStoreSymlink (./. + "/pexels-eberhardgross.jpg");
            target = "Pictures/Wallpapers/pexels-eberhardgross.jpg";
            force = true;
          };
          # "awww" = {
          #   source = config.lib.file.mkOutOfStoreSymlink ./. + "/awww_rand_bg.sh";
          #   target = "${XDG_WALLPAPER_DIR}/awww_rand_bg.sh";
          #   executable = true;
          # };
        };
      };
  };
  den.aspects.wallpaper.provides.awww = {
    nixos =
      {
        pkgs,
        ...
      }:
      let
        start_awww = pkgs.writeShellScriptBin "awww_rand_bg.sh" (builtins.readFile ./awww_rand_bg.sh);
      in
      {
        environment.systemPackages = [
          pkgs.awww
          start_awww
        ];
      };

  };
}
