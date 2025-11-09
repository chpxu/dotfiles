{
  config,
  builtins,
  lib,
  pkgs,
  hostname,
  needsNvidia,
  IPU6 ? {
    enable = false;
    platform = "ipu6ep";
  },
  ...
}: {
  imports = [
    ./nix.nix
    (import ./boot.nix {
      inherit
        config
        pkgs
        lib
        needsNvidia
        ;
    })
    (import ./console.nix {inherit pkgs;})
    ./systemd.nix
    ./security.nix
    (import ./networking.nix {inherit hostname pkgs;})
    (import ./pipewire.nix {inherit pkgs lib;})
    ./zsh.nix
    ./graphics.nix
    ./nano.nix
    ./fonts.nix
    ./xdg.nix
    ./gtk_qt.nix
    ./time_i18n.nix
    ./hyprland.nix
  ];
  services.udisks2 = {
    enable = true;
    mountOnMedia = true;
  };
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  hardware.ipu6.enable = IPU6.enable;
  hardware.ipu6.platform = IPU6.platform;
}
