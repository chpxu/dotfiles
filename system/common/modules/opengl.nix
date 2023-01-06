{
  config,
  pkgs,
  lib,
  needsNvidia,
  needsIntel,
  ...
}: let
  commonExtraPkgs = with pkgs; [
    mesa.drivers
    glfw-wayland
    libvdpau
    libvdpau-va-gl
    vaapiVdpau
    libva
    libdrm
    libGL
    libGLU
    libglvnd
  ];
  nvidiaPackages = with pkgs; [
    nvidia-vaapi-driver
  ];
  intelPackages = with pkgs; [
    vaapiIntel
    intel-media-driver
  ];
in {
  # OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages =
      commonExtraPkgs
      ++ lib.optionals needsNvidia nvidiaPackages
      ++ lib.optionals needsIntel intelPackages;
  };
}
