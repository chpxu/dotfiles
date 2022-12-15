{
  config,
  pkgs,
  lib,
  inputs,
  outputs,
  ...
}: {
  imports = [../../common/commonHome.nix];
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
  };
  nixpkgs = {
    # You can add overlays here
    overlays = with outputs.overlays; [
      # If you want to use overlays your own flake exports (from overlays dir):
      hyprpaper
      xournalpp
      waybar
      discord-canary
      wvkbd
    ];
  };
}
