#!/bin/sh
# This install script is now very minimal, as I have managed to declare pretty much everything via NixOS or home-manager configurations. This script will do a couple things, as the project does not entirely use flakes (namely system configuration is not flakified yet)
# Please ensure you are in root directory of the repo, where this script is located by default
# This script needs root permissions as it messes with system configuration
# 1. Moves all contents in /etc/nixos to a subdirectory called old
# 2. Symlink files in ./system to /etc/nixos
# 3. Add nixos-unstable channel
# 4. Run `sudo nixos-rebuild switch`
# 5. Go to home-manager configuration and run `home-manager switch --flake path:.`

pwd=$(pwd)
# This script also uses sed to change a line in the root flake.nix:
#  modules = [
# - ./system/modified/configuration.nix
# + ./system/configuration.nix
# ]
# This is because I use a private config with more personal data
sed -i "s/modified\/configuration.nix/configuration.nix/g" flake.nix
# 1
sudo mkdir -p /etc/nixos/old
sudo mv -r /etc/nixos/*.* /etc/nios/old/
# 2
sudo ln -s "$pwd/system/configuration.nix" "/etc/nixos/configuration.nix"
sudo ln -s "$pwd/system/hardware-configuration.nix" "/etc/nixos/hardware-configuration.nix"
# 3
nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
nix-channel --update
# 4
sudo nixos-rebuild switch --upgrade
# 5
cd "$pwd/.config/nixpkgs" || echo "Directory not found" && exit
# Use --show-trace in case build fails and issue can be directly analysed
home-manager switch --flake path:. --show-trace 

