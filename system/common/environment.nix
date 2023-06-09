{needsScale, ...}: {
  #Define environment variables used across systems
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "wayland";
    SDL_VIDEODRIVER = "wayland";
    QT_QPA_PLATFORM = "wayland";
    CURL_CA_BUNDLE = "/etc/pki/tls/certs/ca-bundle.crt"; # try to fix curl cannot self-sign error
    LIBSEAT_BACKEND = "logind";
    XCURSOR_SIZE = "32";
    EGL_PLATFORM = "wayland";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
  environment.pathsToLink = ["/share/zsh"];
}
