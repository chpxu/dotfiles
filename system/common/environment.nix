{needsScale, ...}: {
  #Define environment variables used across systems
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "wayland";
    SDL_VIDEODRIVER = "wayland";
    QT_QPA_PLATFORM = "wayland";
    BEMENU_BACKEND = "wayland";
    CURL_CA_BUNDLE = "/etc/pki/tls/certs/ca-bundle.crt"; # try to fix curl cannot self-sign error
    LIBSEAT_BACKEND = "logind";
    XCURSOR_SIZE = "32";
    GDK_SCALE =
      if needsScale
      then "2"
      else "1";
    EGL_PLATFORM = "wayland";
    GBM_BACKEND = "nvidia-drm";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
