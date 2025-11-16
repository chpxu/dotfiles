{
  config,
  hostname,
  pkgs,
  lib,
  inputs,
  ...
}: {
  wayland.windowManager.hyprland = let
    base = (import ./configs/base.nix {inherit pkgs;}).settings;
    extraSettings = (import ./configs/${hostname}.nix).settings;
  in {
    enable = true;
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
    ];
    xwayland = {
      enable = true;
    };
    systemd.enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    settings = lib.recursiveUpdate base extraSettings;
  };

  xdg.configFile = {
    # "hypr/base.conf" = {
    #   source = config.lib.file.mkOutOfStoreSymlink ./. + "/configs/base.conf";
    #   target = "hypr/base.conf";
    # # };
    # "hypr/saitama.conf" = {
    #   source =
    #     if hostname == "saitama"
    #     then config.lib.file.mkOutOfStoreSymlink ./. + "/configs/saitama.conf"
    #     else config.lib.file.mkOutOfStoreSymlink ./. + "/configs/default.conf";
    #   target = "hypr/saitama.conf";
    # };
    "hypr/yoga.conf" = {
      source =
        if hostname == "yoga"
        then config.lib.file.mkOutOfStoreSymlink ./. + "/configs/yoga.conf"
        else config.lib.file.mkOutOfStoreSymlink ./. + "/configs/default.conf";
      target = "hypr/yoga.conf";
    };
    # "hypr/hyprland.conf" = {
    #   source = config.lib.file.mkOutOfStoreSymlink ./. + "/hyprland.conf";
    #   target = "hypr/hyprland.conf";
    # };

    "hypr/hyprpaper.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink ./. + "/hyprpaper.conf";
      target = "hypr/hyprpaper.conf";
    };
    # "hypr/starry_night.png" = {
    #   source = config.lib.file.mkOutOfStoreSymlink ./. + "/starry_night.png";
    #   target = "hypr/starry_night.png";
    #   # credit: https://www.pixiv.net/en/artworks/93958957
    # };
    # "hypr/yor-forger.png" = {
    #   source = config.lib.file.mkOutOfStoreSymlink ./. + "/yor-forger.png";
    #   target = "hypr/yor-forger.png";
    #   # credit: TODO
    # };
    # "hypr/kafkasw.jpg" = {
    #   # https://twitter.com/jeonghee1414/status/1657279512424615938/photo/1
    #   source = config.lib.file.mkOutOfStoreSymlink ./. + "/kafkasw.jpg";
    #   target = "hypr/kafkasw.jpg";
    # };
    # "hypr/void_0_jl.jpg" = {
    #   # https://twitter.com/jeonghee1414/status/1657279512424615938/photo/1
    #   source = config.lib.file.mkOutOfStoreSymlink ./. + "/void_0_jl.jpg";
    #   target = "hypr/void_0_jl.jpg";
    # };
  };
}
