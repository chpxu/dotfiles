{
  config,
  pkgs,
  # lib,
  colour-palette,
  ...
}: {
  imports = [
    # ./wayfire
    (import ./hyprland/xdg.nix {inherit config;})
    ./zsh
    ./starship
    ./Discord
    ./Code
    ./gh_git
    ./direnv
    ./waybar
    ./zathura
    ./mpv
    (import ./kitty {inherit pkgs colour-palette;})
    ./mako
    ./sway
    ./xdg/xdg.nix
    ./python
    ./firefox
    ./wofi
    ./jq
  ];
  # imports = builtins.map (dir: (import (./. + "/${dir}") {inherit pkgs colour-palette;})) (builtins.attrNames (builtins.readDir (builtins.toPath ./. + "/")));
}
