{config, ...}: {
  # xdg.configFile."swaylock/config" = {
  #   source = config.lib.file.mkOutOfStoreSymlink ./. + "/config/swaylock/config";
  #   target = "swaylock/config";
  # };
  xdg.configFile."swaylock/blue_swirl.png" = {
    source = config.lib.file.mkOutOfStoreSymlink ./. + "/blue_swirl.png";
    target = "swaylock/blue_swirl.png";
  };
}
