{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    texlive.combined.scheme-full # TODO: remove? replace with rlt to reduce closure
    ltex-ls
    nil
    zmqpp
    spyder
  ];
}
