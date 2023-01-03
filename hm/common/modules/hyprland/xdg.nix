{
  config,
  lib,
  options,
  specialArgs,
  modulesPath,
  ...
}: {
  xdg.configFile = {
    "hypr/hyprpaper.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink ./. + "/hyprpaper.conf";
      target = "hypr/hyprpaper.conf";
    };
    "hypr/starry_night.png" = {
      source = config.lib.file.mkOutOfStoreSymlink ./. + "/starry_night.png";
      target = "hypr/starry_night.png";
      # credit: https://www.pixiv.net/en/artworks/93958957
    };
    "hypr/yor-forger.png" = {
      source = config.lib.file.mkOutOfStoreSymlink ./. + "/yor-forger.png";
      target = "hypr/yor-forger.png";
      # credit: TODO
    };
  };
}
