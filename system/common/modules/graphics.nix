{
  pkgs,
  lib,
  needsNvidia,
  needsIntel,
  ...
}: let
  commonExtraPkgs = with pkgs; [
    libvdpau
    libvdpau-va-gl
    libva-vdpau-driver
    libva
    libdrm
    libGL
    libGLU
    libglvnd
    egl-wayland
  ];
  nvidiaPackages = with pkgs; [
    nvidia-vaapi-driver
  ];
  intelPackages = with pkgs; [
    intel-vaapi-driver
    intel-media-driver
  ];
in {
  # OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages =
      commonExtraPkgs
      ++ lib.optionals needsNvidia nvidiaPackages
      ++ lib.optionals needsIntel intelPackages;
  };
  services.lact.enable = true;
}
