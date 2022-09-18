{
  config,
  pkgs,
  ...
}: let
  nord = import ../../common/nordtheme.nix;
in {
  programs.mako = {
    enable = true;
    # package = pkgs.mako;
    actions = true;
    anchor = "top-right";
    backgroundColor = "${nord.nord0}";
    borderSize = 2;
    borderRadius = 5;
    borderColor = "${nord.nord4}";
    textColor = "${nord.nord4}";
    defaultTimeout = 2500;
    ignoreTimeout = true;
    maxIconSize = 64;
    maxVisible = 10;
    markup = true;
    icons = true;
    iconPath = "/usr/share/icons:~/.local/share/icons:/usr/share/pixmaps";
    font = "FiraCode Nerd Font 10";
    height = 110;
    width = 300;
    sort = "-priority";
    layer = "overlay";
    padding = "10";
    progressColor = "over ${nord.nord14}";
    extraConfig = ''
      [urgency=low]
      border-color=${nord.nord8}

      [urgency=normal]
      border-color=${nord.nord13}

      [urgency=high]
      border-color=${nord.nord12}
      default-timeout=0

      [category=mpd]
      default-timeout=2000
      border-color=${nord.nord11}
      group-by=category
    '';
  };
}
