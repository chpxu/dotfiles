{
  config,
  lib,
  options,
  specialArgs,
  modulesPath,
  ...
}: let
  paths = import ./. + "../../common/paths.nix";
in {
  xdg.configFile."waybar/wvkbd.sh" = {
    source = config.lib.file.mkOutOfStoreSymlink ./. + "/config/wvkbd.sh";
    target = "waybar/wvkbd.sh";
  };
}
