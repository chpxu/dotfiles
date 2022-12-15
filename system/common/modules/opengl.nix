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
    libvdpau-va-gl
    vaapiVdpau
    libva
    libdrm
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
      ++ lib.optional needsIntel pkgs.vaapiIntel
      ++ lib.optional needsIntel pkgs.intel-media-driver;
  };
}
