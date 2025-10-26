{pkgs, ...}: let
  normalPackages = with pkgs; [
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
  services.cliphist.enable = true;
  home.packages = normalPackages;
}
