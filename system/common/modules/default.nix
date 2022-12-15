{hostname, ...}: {
  imports = [
    ./pipewire.nix
    ./nano.nix
    ./zsh.nix
    ./security.nix
    (import ./networking.nix {inherit hostname;})
    ./fonts.nix
    ./xdg.nix
    ./gtk_qt.nix
    ./opengl.nix
  ];
}
