{
  config,
  lib,
  options,
  specialArgs,
  modulesPath,
  ...
}: {
  xdg.configFile."waybar/wvkbd.sh" = {
    source = config.lib.file.mkOutOfStoreSymlink ./. + "/config/wvkbd.sh";
    target = "waybar/wvkbd.sh";
  };
}
