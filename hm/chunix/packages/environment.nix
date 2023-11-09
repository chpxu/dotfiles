{pkgs, ...}: let
  normalPackages = with pkgs; [
    cliphist
    grim
    slurp
    swayidle
    wl-clipboard
    wofi
    imv
    krusader
    xdg-utils
    unzip
    jmtpfs
  ];
  # xprop = [pkgs.xorg.xprop];
in {
  home.packages = normalPackages;
}
