{config, ...}: {
  xdg.configFile = {
    "hypr/hyprland.conf" = {
      # https://twitter.com/jeonghee1414/status/1657279512424615938/photo/1
      source = config.lib.file.mkOutOfStoreSymlink ./. + "/hyprland.conf";
      target = "hypr/hyprland.conf";
    };
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
    "hypr/kafkasw.jpg" = {
      # https://twitter.com/jeonghee1414/status/1657279512424615938/photo/1
      source = config.lib.file.mkOutOfStoreSymlink ./. + "/kafkasw.jpg";
      target = "hypr/kafkasw.jpg";
    };
  };
}
