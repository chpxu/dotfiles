{
  config,
  lib,
  options,
  specialArgs,
  modulesPath,
  inputs,
  outputs,
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
    # ./kanshi
    ./xdg/xdg.nix
    #//texlive.nix
    ./python
    ./firefox
    # ./neovim
    ./wofi
    ./zsh
    ./hyprland/xdg.nix
    # ./starship
    ./jq
    # ./modules/osu-stable
    # ./modules/wireplumber
  ];
}
