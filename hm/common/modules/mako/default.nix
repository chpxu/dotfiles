{colour-palette, ...}: {
  services.mako = {
    enable = true;
    # package = pkgs.mako;
    settings = {
      actions = true;
      anchor = "top-right";
      background-color = "${colour-palette.nord0}";
      border-size = 2;
      border-radius = 5;
      border-color = "${colour-palette.nord4}";
      text-color = "${colour-palette.nord4}";
      default-timeout = 2500;
      ignore-timeout = true;
      max-icon-size = 64;
      max-visible = 10;
      markup = true;
      icons = true;
      icon-path = "/usr/share/icons:~/.local/share/icons:/usr/share/pixmaps";
      font = "FiraCode Nerd Font 16";
      height = 110;
      width = 300;
      sort = "-priority";
      layer = "overlay";
      padding = "10";
      progress-color = "over ${colour-palette.nord14}";
    };
    extraConfig = ''
      [urgency=low]
      border-color=${colour-palette.nord8}

      [urgency=normal]
      border-color=${colour-palette.nord13}

      [urgency=high]
      border-color=${colour-palette.nord12}
      default-timeout=2000

      [category=mpd]
      default-timeout=2000
      border-color=${colour-palette.nord11}
      group-by=category
    '';
  };
}
