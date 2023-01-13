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

  imports = [../../common/commonHome.nix];
  # home.activation = {
  #   fix-vscode = lib.hm.dag.entryAfter ["writeBoundary"] ''
  #     # rm -r $HOME/.vscode/extension-old
  #     cp -LR $HOME/.vscode/extensions $HOME/.vscode/old
  #     mv $HOME/.vscode/extensions $HOME/.vscode/extension-old
  #     mv $HOME/.vscode/old $HOME/.vscode/extensions
  #     sleep 1
  #     chmod 775 -R $HOME/.vscode/extensions
  #     # chmod 775 -R $HOME/.vscode/extensions
  #   '';
  # };
}
