{
  extraConfig =
    ''
      #FIXME
      monitor=eDP-1,preferred,0x0,1,bitdepth,10
    ''
    + (import ../../../../common/modules/hyprland/commonConfig.nix).commonConfig;
}
