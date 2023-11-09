{pkgs, ...}: {
  home.packages = with pkgs; [
    ltex-ls
    nil
    texlive.combined.scheme-full
  ];
}
