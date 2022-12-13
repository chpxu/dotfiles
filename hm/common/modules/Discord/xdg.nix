{
  config,
  builtins,
  ...
}: let
  nord-zelk = "nord-zelk.theme.css";
  zelk = "zelkBD.theme.css";
  # paths = import ../../common/paths.nix;
in {
  xdg.configFile = {
    "nord-zelk.theme.css" = {
      source = config.lib.file.mkOutOfStoreSymlink ./. + "/themes/${nord-zelk}";
      target = "BetterDiscord/themes/${nord-zelk}";
    };
    "zelkBD.theme.css" = {
      source = config.lib.file.mkOutOfStoreSymlink ./. + "/themes/${zelk}";
      target = "BetterDiscord/themes/${zelk}";
    };
    "settings.json" = {
      text = (import ./config/settings.nix).settings;
    	target = "discordcanary/settings.json";
    };
  };
}
