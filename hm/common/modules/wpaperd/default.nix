{config, ...}: let
  XDG_WALLPAPER_DIR = "${config.home.homeDirectory}/Pictures/Wallpapers";
in {
  services.wpaperd.enable = true;
  services.wpaperd.settings = {
    default = {
      duration = "10m";
      mode = "center";
      sorting = "ascending";
      path = "${config.home.homeDirectory}/Pictures/Wallpapers";
    };
    any = {
      path = "${config.home.homeDirectory}/Pictures/Wallpapers";
    };
    "AOC AG276QZD2 2OMR5JA003095" = {
      mode = "stretch";
      path = "${config.home.homeDirectory}/Pictures/Wallpapers";
      transition."cross-warp" = {};
      transition-time = 1000;
    };
    "AOC 24G2W1G4 0x00004A8B" = {
      mode = "center";
      path = "${config.home.homeDirectory}/Pictures/Wallpapers";
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
}
