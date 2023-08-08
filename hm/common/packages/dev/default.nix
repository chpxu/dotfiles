{pkgs, ...}: {
  home.packages = with pkgs; [
    ltex-ls
    nil
  ];
}
