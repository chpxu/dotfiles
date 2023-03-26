{
  extraConfig =
    ''
       #xec-once=xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 2
      monitor=,3840x2160@60,0x0,2
    ''
    + (import ../../../../common/modules/hyprland/commonConfig.nix).commonConfig;
}
