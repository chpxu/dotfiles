{
  pkgs,
  isLegion ? false,
  ...
}: let
  normalPackages = with pkgs; [
    bemenu
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
    wev
  ];
  xprop = [pkgs.xorg.xprop];
in {
  home.packages =
    if isLegion == false
    then normalPackages ++ xprop
    else normalPackages;
}
