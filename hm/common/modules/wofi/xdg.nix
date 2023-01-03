{
  config,
  lib,
  colour-palette,
  ...
}: {
  xdg.configFile = {
    "wofi/config" = {
      text = import ./settings/settings.nix {inherit colour-palette;};
      target = "wofi/config";
    };
    "wofi/style.css" = {
      text = (import ./settings/style.nix).style;
      target = "wofi/style.css";
    };
  };
}
