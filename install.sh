#!/bin/sh
# This install script aims to be very minimal, as I have tried to declare pretty much everything via NixOS or home-manager configurations. 
# Takes in 2 arguments: hostname and username
# Please ensure you are in the repo root directory
# This script needs root permissions as it messes with system configuration
# 1. Moves all contents in /etc/nixos to a subdirectory called old
# 2. Run `sudo nixos-rebuild switch --flake .#hostname --impure --show-trace --upgrade`
# 3. Go to home-manager configuration and run `home-manager switch --flake .#username@hostname --impure --show-trace`

usernames="chunix"
hostnames="legion yoga"
for hostname in $hostnames
do
    if [ "$1" != "$hostname" ]; then
        echo "Not a valid hostname"
        exit
    fi
done
for username in $usernames
do
    if [ "$2" != "$username" ]; then
        echo "Not a valid username"
        exit
    fi
done
# 1
etcNixos="/etc/nixos"
sudo mkdir -p "$etcNixos/old"
sudo mv -r $etcNixos/*.* $etcNixos/old/
# 2
sudo nixos-rebuild boot --flake .\#"$1" --impure --show-trace --upgrade
sudo nixos-rebuild reboot
echo "Successful system upgrade"

# 3
home-manager switch --flake .\#"$2@$1" --impure --show-trace

echo "Successful upgrade for home user $2"
echo ""
echo "You may want to restart your PC, or at least logout and log back in to see changes applied"
