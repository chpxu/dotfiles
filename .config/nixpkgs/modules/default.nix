{
  config,
  lib,
  options,
  specialArgs,
  modulesPath,
  inputs,
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
    ./kitty
    ./mako
    ./sway
    ./kanshi
    ./xdg/xdg.nix
    #//texlive.nix
    ./python
    ./firefox
    ./neovim
    ./wofi
    ./zsh
    ./hyprland
    ./starship
    # ./modules/osu-stable
    # ./modules/wireplumber
  ];
}
