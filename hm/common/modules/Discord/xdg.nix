{
  config,
  lib,
  ...
}: let
  nord-zelk = "nord-zelk.theme.css";
  zelk = "zelkBD.theme.css";
  clear = "nordic-clear-vision.theme.css";
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
    "nordic-clear-vision.theme.css" = {
      source = config.lib.file.mkOutOfStoreSymlink ./. + "/themes/${clear}";
      target = "BetterDiscord/themes/${clear}";
    };
    # "settings.json" = {
    #   text = (import ./config/settings.nix).settings;
    #   target = "discordcanary/settings.json";
    # };
  };
  home.extraBuilderCommands = ''
    nix-env -i --set-flag 0 betterdiscordctl
    betterdiscordctl --d-modules "$HOME/.config/discordcanary/0.0.145/modules" reinstall
    nix-env --uninstall betterdiscordctl
  '';
}
