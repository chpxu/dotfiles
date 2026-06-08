_: {
  den.aspects.graphics =
    { pkgs, ... }:
    let
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
      intelPackages = with pkgs; [
        intel-vaapi-driver
        intel-media-driver
      ];
    in
    {
      nixos = _: {
        hardware.graphics = {
          enable = true;
          enable32Bit = true;
          extraPackages = commonExtraPkgs;
        };
        services.lact.enable = true;
      };
    };
}
