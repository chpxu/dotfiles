{
  config,
  pkgs,
  lib,
  colour-palette,
  ...
}: {
  imports = [
    (import ./hyprland/xdg.nix {inherit config;})
    ./zsh
    ./systemd
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
    ./firefox
    ./jq
  ];
  # Reset GPUCaches because they seem to break after upgrading
  home.activation = {
    deleteGPUCache = lib.hm.dag.entryAfter ["writeBoundary"] ''
      rm -rf ${config.xdg.configHome}/**/GPUCache
    '';
  };

  # imports = builtins.map (dir: (import (./. + "/${dir}") {inherit pkgs colour-palette;})) (builtins.attrNames (builtins.readDir (builtins.toPath ./. + "/")));
}
