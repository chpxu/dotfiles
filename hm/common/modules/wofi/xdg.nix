{colour-palette, ...}: {
  xdg.configFile = {
    "wofi/config" = {
      text = (import ./settings/settings.nix).wofiConfig;
      target = "wofi/config";
    };
    "wofi/style.css" = {
      text = (import ./settings/style.nix {inherit colour-palette;}).style;
      target = "wofi/style.css";
    };
  };
}
