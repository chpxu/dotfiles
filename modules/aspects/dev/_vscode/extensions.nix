{ pkgs, ... }:
{
  extensions = with pkgs.vscode-extensions; [
    arcticicestudio.nord-visual-studio-code
    jnoortheen.nix-ide
    mkhl.direnv
  ];
  # ++ (map (x: (fetchExt x)) fetched);
}
