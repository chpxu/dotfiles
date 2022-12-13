{ config,  ...}:
let
paths = import ../../common/paths.nix;
in
{
  xdg.configFile."swaylock/config" = {
    source = config.lib.file.mkOutOfStoreSymlink /. + "${paths.modules}/sway/config/swaylock/config";
    target = "swaylock/config";
  }
}