{
  config,
  lib,
  options,
  specialArgs,
  modulesPath,
}: {
  imports = [
    ./wayfire
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
    # ./modules/osu-stable
    # ./modules/wireplumber
  ];
}
