{
  inputs,
  pkgs,
  needsNvidia ? false,
  ...
}: {
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    enableNvidiaPatches = needsNvidia;
  };
}
