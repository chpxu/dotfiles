{
  config,
  pkgs,
  lib,
  inputs,
  outputs,
  ...
}: {
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    _JAVA_AWT_WM_NONREPARENTING = 1;
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = 1;
  };

  nixpkgs = {
    overlays = with outputs.overlays; [
      hyprpaper
      xournalpp
      waybar
      discord-canary
      wvkbd
    ];
  };
  imports = [../../common/commonHome.nix];
}
