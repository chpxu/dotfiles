rec {
  # General Paths to dotfiles repo
  repoConfigPath = "/home/chunix/git_projects/dotfiles/.config";
  nixpkgsPath = "${repoConfigPath}/nixpkgs";
  common = "${nixpkgsPath}/common";
  modules = "${nixpkgsPath}/modules";
  overlays = "${nixpkgsPath}/overlays";
  theme = "${common}/nordtheme.nix";
}
