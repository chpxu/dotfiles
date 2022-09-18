{
  config,
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = (import ./settings.nix).settings;
    style = (import ./style.nix).style;
  };
}
