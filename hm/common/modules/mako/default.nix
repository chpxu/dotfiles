{
  config,
  lib,
  colour-palette,
  ...
}: {
  programs.mako = {
    enable = true;
    # package = pkgs.mako;
    actions = true;
    anchor = "top-right";
    backgroundColor = "${colour-palette.nord0}";
    borderSize = 2;
    borderRadius = 5;
    borderColor = "${colour-palette.nord4}";
    textColor = "${colour-palette.nord4}";
    defaultTimeout = 2500;
    ignoreTimeout = true;
    maxIconSize = 64;
    maxVisible = 10;
    markup = true;
    icons = true;
    iconPath = "/usr/share/icons:~/.local/share/icons:/usr/share/pixmaps";
    font = "FiraCode Nerd Font 12";
    height = 110;
    width = 300;
    sort = "-priority";
    layer = "overlay";
    padding = "10";
    progressColor = "over ${colour-palette.nord14}";
    extraConfig = ''
      [urgency=low]
      border-color=${colour-palette.nord8}

      [urgency=normal]
      border-color=${colour-palette.nord13}

      [urgency=high]
      border-color=${colour-palette.nord12}
      default-timeout=0

      [category=mpd]
      default-timeout=2000
      border-color=${colour-palette.nord11}
      group-by=category
    '';
  };
}
