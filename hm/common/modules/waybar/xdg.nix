{config, ...}: {
  xdg.configFile."waybar/wvkbd.sh" = {
    source = config.lib.file.mkOutOfStoreSymlink ./. + "/config/wvkbd.sh";
    target = "waybar/wvkbd.sh";
  };
  xdg.configFile."waybar/nixoslogo.svg" = {
    source = config.lib.file.mkOutOfStoreSymlink ./. + "/config/nixoslogo.svg";
    target = "waybar/nixoslogo.svg";
  };
}
