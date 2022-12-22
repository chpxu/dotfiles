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
in {
  # OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages =
      commonExtraPkgs
      ++ lib.optional needsNvidia pkgs.nvidia-vaapi-driver
      ++ lib.optional needsNvidia pkgs.egl-wayland
      ++ lib.optional needsIntel pkgs.vaapiIntel
      ++ lib.optional needsIntel pkgs.intel-media-driver;
  };
}
