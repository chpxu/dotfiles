{
  config,
  pkgs,
  ...
}: {
  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
      });
    })
  ];
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = (import ./settings.nix).settings;
    style = (import ./style.nix).style;
  };
}
