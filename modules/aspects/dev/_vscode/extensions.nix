{ pkgs, ... }:
let
  fetchExt = ext: (pkgs.vscode-utils.extensionFromVscodeMarketplace ext);
  fetched = [
    {
      name = "remote-ssh";
      publisher = "ms-vscode-remote";
      version = "0.114.2024080815";
      sha256 = "sha256-F01eQR/A8X18K3CTxMS5D+7vgSVLb5L8w8qYkxgapEs=";
    }
    {
      name = "remote-ssh-edit";
      publisher = "ms-vscode-remote";
      version = "0.86.0";
      sha256 = "sha256-JsbaoIekUo2nKCu+fNbGlh5d1Tt/QJGUuXUGP04TsDI=";
    }
    {
      name = "remote-explorer";
      publisher = "ms-vscode";
      version = "0.5.2024070409";
      sha256 = "sha256-YwmsZii8TvBhloNQi6mezusEf/SmIq3i1ZNyKN5j1sU=";
    }
  ];
in
{
  extensions =
    with pkgs.vscode-extensions;
    [
      arcticicestudio.nord-visual-studio-code
      jnoortheen.nix-ide
      mkhl.direnv
    ];
    # ++ (map (x: (fetchExt x)) fetched);
}
