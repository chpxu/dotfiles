{
  pkgs,
  config,
  lib,
  options,
  specialArgs,
  modulesPath,
}: let
  paths = import ../../common/paths.nix;
in {
  xdg.configFile = {
    "wayfire.ini" = {
      source = config.lib.file.mkOutOfStoreSymlink ./. + "/config/wayfire.ini";
      target = "wayfire.ini";
    };
    "wf-shell.ini" = {
      source = config.lib.file.mkOutOfStoreSymlink ./. + "/config/wf-shell.ini";
      target = "wf-shell.ini";
    };
  };
  xdg.desktopEntries.wayfire = {
    exec = "${pkgs.wayfire}/bin/wayfire";
    genericName = "Wayfire";
    name = "Wayfire";
    type = "Application";
    settings = {
      # DesktopNames = "Wayfire";
    };
  };
}
