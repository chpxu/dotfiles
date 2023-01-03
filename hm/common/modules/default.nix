{
  # config,
  pkgs,
  # lib,
  colour-palette,
  ...
}: {
  imports = [
    # ./wayfire
    ./Discord
    ./Code
    ./gh_git
    ./waybar
    ./zathura
    ./mpv
    (import ./kitty {inherit pkgs colour-palette;})
    ./mako
    ./sway
    # ./kanshi
    ./xdg/xdg.nix
    #//texlive.nix
    ./python
    ./firefox
    # ./neovim
    ./wofi
    # ./zsh
    ./hyprland/xdg.nix
    # ./starship
    ./jq
    # ./modules/osu-stable
    # ./modules/wireplumber
  ];
  # imports = builtins.map (dir: (import (./. + "/${dir}") {inherit pkgs colour-palette;})) (builtins.attrNames (builtins.readDir (builtins.toPath ./. + "/")));
}
