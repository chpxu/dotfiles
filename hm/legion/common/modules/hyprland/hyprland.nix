{
  extraConfig =
    ''
      exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      exec-once=systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      #FIXME
      monitor=eDP-1,2560x1600@144,0x0,1,bitdepth,10
    ''
    + (import ../../../../common/modules/hyprland/commonConfig.nix).commonConfig;
}
