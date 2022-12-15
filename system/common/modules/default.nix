{
  builtins,
  pkgs,
  hostname,
  ...
}: {
  imports = [
    ./pipewire.nix
    ./nano.nix
    ./zsh.nix
    ./security.nix
    (import ./networking.nix {inherit hostname builtins;})
    ./fonts.nix
    (import ./xdg.nix {inherit pkgs;})
    ./gtk_qt.nix
    ./opengl.nix
  ];
}
