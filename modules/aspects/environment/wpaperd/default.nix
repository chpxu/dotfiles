_: {
  den.aspects.wpaperd = {
    homeManager =
      { config, ... }:
      let
        XDG_WALLPAPER_DIR = "${config.home.homeDirectory}/Pictures/Wallpapers";
      in
      {
        services.wpaperd.enable = true;
        services.wpaperd.settings = {
          default = {
            duration = "10m";
            mode = "center";
            sorting = "ascending";
            path = "${XDG_WALLPAPER_DIR}";
          };
          any = {
            path = "${XDG_WALLPAPER_DIR}";
          };
          "AOC AG276QZD2 2OMR5JA003095" = {
            mode = "stretch";
            path = "${XDG_WALLPAPER_DIR}";
            transition."cross-warp" = { };
            transition-time = 1000;
          };
          "AOC 24G2W1G4 0x00004A8B" = {
            mode = "center";
            path = "${XDG_WALLPAPER_DIR}";
            transition-time = 2000;
            transition.doom = {
              bars = 50;
            };
          };
        };
        home.file = {
          "wallpaper1" = {
            source = config.lib.file.mkOutOfStoreSymlink ./. + "/john-towner1.jpg";
            target = "${XDG_WALLPAPER_DIR}/john-towner1.jpg";
          };
          "wallpaper2" = {
            source = config.lib.file.mkOutOfStoreSymlink ./. + "/pexels-eberhardgross.jpg";
            target = "${XDG_WALLPAPER_DIR}/pexels-eberhardgross.jpg";
          };
        };
      };
  };
}
