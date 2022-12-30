{
  config,
  pkgs,
  lib,
  inputs,
  outputs,
  ...
}: {
  home.sessionVariables = {
    #MOZ_ENABLE_WAYLAND = 1;
    _JAVA_AWT_WM_NONREPARENTING = 1;
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = 1;
    MOZ_DISABLE_RDD_SANDBOX = 1;
    MOZ_X11_EGL = 1;
    # __EGL_VENDOR_LIBRARY_FILENAMES =
    #"${config.boot.kernelPackages.nvidiaPackages.beta}/share/glvnd/egl_vendor.d/10_nvidia.json";
  };

  nixpkgs = {
    overlays = with outputs.overlays; [
      clisp
      hyprpaper
      xournalpp
      waybar
      discord-canary
      wvkbd
      bitwarden
    ];
  };
  home.packages = with pkgs; [
    # other applications may be in overlays
    clisp
    discord-canary
    bitwarden
    waybar
    hyprpaper
    wvkbd
    xournalpp
  ];
  imports = [../../common/commonHome.nix];
}
