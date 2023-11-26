{pkgs, ...}: {
  home.packages = with pkgs; [
    ltex-ls
    nil
    texlive.combined.scheme-full
		#libsForQt5.qt5.qtwayland
  ];
}
