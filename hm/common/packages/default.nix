{pkgs, ...}: {
  imports = [
    ./daily
    ./dev
    ./environment.nix
  ];
  home.packages = with pkgs; [
    # other applications may be in overlays
    #clisp
    discord-canary
    bitwarden
    waybar
    hyprpaper
    wvkbd
    logseq
    zotero
    #rpi-imagerstable
  ];
}
