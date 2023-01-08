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
    (import ./kernel.nix {
      inherit pkgs lib;
      rtVer = "14";
      version = "6.0.11";
      sha256 = "sha256-O91YPsyzr8sbpXF+aYZTNSj88DQnAigZMsEovw5Veok=";
    })
    ./nano.nix
    ./zsh.nix
    ./security.nix
    (import ./networking.nix {inherit hostname config lib builtins;})
    ./fonts.nix
    (import ./xdg.nix {inherit pkgs;})
    ./gtk_qt.nix
    ./opengl.nix
    ./time_i18n.nix
    ./pipewire.nix
  ];
}
