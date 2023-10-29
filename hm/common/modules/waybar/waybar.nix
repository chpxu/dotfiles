{
  config,
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = (import ./settings.nix {inherit config;}).settings;
    style = (import ./style.nix).style;
  };
}
