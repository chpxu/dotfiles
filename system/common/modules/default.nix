{
  config,
  builtins,
  lib,
  pkgs,
  hostname,
  ...
}: {
  imports = [
    ./nix.nix
    ./boot.nix
    (import ./console.nix {inherit pkgs;})
    ./systemd.nix
    ./nano.nix
    ./zsh.nix
    ./security.nix
    (import ./networking.nix {inherit hostname config lib builtins;})
    ./fonts.nix
    ./xdg.nix
    ./gtk_qt.nix
    ./opengl.nix
    ./time_i18n.nix
    ./pipewire.nix
    ./hyprland.nix
  ];
  services.udisks2 = {
		enable = true;
		mountOnMedia = true;
  };
}
