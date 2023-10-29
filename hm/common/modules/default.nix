{
  config,
  pkgs,
  # lib,
  colour-palette,
  ...
}: {
  imports = [
    (import ./hyprland/xdg.nix {inherit config;})
    ./zsh
    # ./starship
    ./systemd
    ./Discord
    ./Code
    ./gh_git
    ./direnv
    ./waybar
    ./zathura
    ./mpv
    (import ./kitty {inherit pkgs colour-palette;})
    ./rofi/rofi.nix
    ./mako
    ./sway
    ./xdg/xdg.nix
    # ./python
    ./firefox
    # ./wofi
    ./jq
  ];
  # imports = builtins.map (dir: (import (./. + "/${dir}") {inherit pkgs colour-palette;})) (builtins.attrNames (builtins.readDir (builtins.toPath ./. + "/")));
}
