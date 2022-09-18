{
  config,
  lib,
  options,
  specialArgs,
  modulesPath,
}: {
  xdg.configFile = {
    "wofi/config" = {
      text = (import ./settings/settings.nix).wofiConfig;
      target = "wofi/config";
    };
    "wofi/style.css" = {
      text = (import ./settings/style.nix).style;
      target = "wofi/style.css";
    };
  };
}
