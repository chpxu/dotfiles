{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    texlive.combined.scheme-full
    ltex-ls
    nil
  ];
}
