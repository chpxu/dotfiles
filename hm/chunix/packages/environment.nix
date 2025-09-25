{pkgs, ...}: let
  normalPackages = with pkgs; [
    cliphist
    grim
    slurp
    swayidle
    wl-clipboard
    wofi
    imv
    xdg-utils
    unzip
    jmtpfs
    dragon-drop
  ];
  # xprop = [pkgs.xorg.xprop];
in {
  home.packages = normalPackages;
}
