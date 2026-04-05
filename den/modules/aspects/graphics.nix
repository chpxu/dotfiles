{
  den,
  lib,
  ...
}: {
  den.aspects.graphics = {pkgs, ...}: let
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
    nixos = {config}: {
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages =
          commonExtraPkgs
          ++ nvidiaPackages
          ++ intelPackages;
      };
      services.lact.enable = true;
    };
  };
  # OpenGL
}
