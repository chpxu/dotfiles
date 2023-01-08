{
  extraConfig =
    ''
      exec-once=xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 2
      monitor=eDP-1,3840x2160@60,0x0,1.5,bitdepth,10

      decoration {
        blur = false

      }
      misc {
        no_vfr = false
      }
    ''
    + (import ../../../../common/modules/hyprland/commonConfig.nix).commonConfig;
}
