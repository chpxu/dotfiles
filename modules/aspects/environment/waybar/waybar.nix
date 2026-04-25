_: {
  den.aspects.waybar = {
    homeManager =
      {
        config,
        pkgs,
        nordtheme,
        ...
      }:
      {
        programs.waybar = {
          enable = true;
          package = pkgs.waybar;
          settings = (import ./_settings.nix).settings;
          style = (import ./_style.nix { inherit nordtheme; }).style;
        };
        xdg.configFile."waybar/wvkbd.sh" = {
          source = config.lib.file.mkOutOfStoreSymlink ./. + "/_config/wvkbd.sh";
          target = "waybar/wvkbd.sh";
        };
        xdg.configFile."waybar/nixoslogo.svg" = {
          source = config.lib.file.mkOutOfStoreSymlink ./. + "/_config/nixoslogo.svg";
          target = "waybar/nixoslogo.svg";
        };
      };
  };
}
