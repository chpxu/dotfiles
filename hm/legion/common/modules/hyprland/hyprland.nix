{
  extraConfig =
    ''
      #FIXME
      monitor=eDP-1,2560x1600@165,0x0,1
    ''
    + (import ../../../../../common/modules/hyprland/commonConfig.nix).commonConfig;
}
