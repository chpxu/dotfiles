{
  config,
  hostname,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  wayland.windowManager.hyprland =
    let
      base =
        (import ./configs/base.nix {
          inherit
            pkgs
            config
            lib
            inputs
            ;
        }).settings;
      extraSettings = (import ./configs/${hostname}.nix).settings;
      touchpad = (import ./configs/touchpad.nix).settings;
    in
    {
      enable = true;
      plugins = [
        inputs.hyprsplit.packages.${pkgs.stdenv.hostPlatform.system}.hyprsplit
      ];
      systemd.enable = true;
      systemd.enableXdgAutostart = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      settings = lib.recursiveUpdate base (extraSettings // touchpad);
    };

  xdg.configFile = {
    "hypr/yoga.conf" = {
      source =
        if hostname == "yoga" then
          config.lib.file.mkOutOfStoreSymlink ./. + "/configs/yoga.conf"
        else
          config.lib.file.mkOutOfStoreSymlink ./. + "/configs/default.conf";
      target = "hypr/yoga.conf";
    };

    "hypr/hyprpaper.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink ./. + "/hyprpaper.conf";
      target = "hypr/hyprpaper.conf";
    };
  };
}
