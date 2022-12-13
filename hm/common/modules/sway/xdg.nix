{ config,  ...}:
{
  xdg.configFile."swaylock/config" = {
    source = config.lib.file.mkOutOfStoreSymlink ./. + "/config/swaylock/config";
    target = "swaylock/config";
  }
}