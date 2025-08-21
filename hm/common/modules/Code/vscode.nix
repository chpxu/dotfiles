{pkgs, ...}: {
  programs.vscode = with pkgs; {
    enable = true;
    package = vscode-fhs;
    profiles.default.extensions = (import ./config/extensions.nix {inherit pkgs;}).extensions;
    # userSettings = (import ./config/settings.nix {inherit pkgs;}).settings;
  };
}
