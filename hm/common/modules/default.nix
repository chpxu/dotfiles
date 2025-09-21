{
  config,
  pkgs,
  lib,
  colour-palette,
  hostname,
  inputs,
  ...
}: {
  imports = [
    ./xdg/xdg.nix
    (import ./hyprland/xdg.nix {
      inherit config hostname pkgs inputs;
    })
    ./wpaperd
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
    ./firefox
    ./jq
    ./syncthing
  ];
  # Reset GPUCaches because they seem to break after upgrading
  home.activation = {
    deleteGPUCache = lib.hm.dag.entryAfter ["writeBoundary"] ''
      rm -rf ${config.xdg.configHome}/**/GPUCache
    '';
  };

  # imports = builtins.map (dir: (import (./. + "/${dir}") {inherit pkgs colour-palette;})) (builtins.attrNames (builtins.readDir (builtins.toPath ./. + "/")));
}
