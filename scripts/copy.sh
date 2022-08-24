#!/bin/sh
# This script copies files to and from appropriate destionations in $HOME to the repository folder. 
# Ensure this script has executable permissions with chmod +x copy.sh
# Copying to your $HOME means you should execute ./copy.sh dotfiles
# Executing "./copy.sh nixfiles" will copy my configurations in .config/nixpkgs to this repo. This is intended for me only but up to you if you want your own nixfiles.
# Executing ``./copy.sh configuration "/path/to/copy"`` will copy configuration.nix, hardware-configuration.nix, tlp.nix, pipewire.nix to your desired folder. By default this is assumed to be /etc/nixos.
# Please edit hardware-configuration.nix with your hardware before building!
# This script requires an internet connection to connect to packages and override some packages to my own repositories.
# This script is a WIP, as is everything else in this repository

# Writing copying to home section
# This will overwrite your current configurations, please make sure you have them backed up if you care!
if [ "$1" = "dotfiles" ]; then
  cp -r ../.config $HOME/
  cp -r ../.mozilla $HOME/
  cp -r ../Pictures $HOME/
fi

# declare -a CONFIGFOLDER=("BetterDiscord" "kanshi" "kitty" "mako" "nano" "neofetch" "swaylock" "waybar" "wlogout" "wofi"  "zathura")

if [ "$1" = "nixfiles" ]; then
  configDir="$HOME/.config"
  cd "$configDir"
  # mapfile -t symlinks <<< "$(find . -maxdepth 1 -type l)"
  IFS=$'\n' read -r -d '' symlinks <<< "$(find . -type l)"

  for entry in $symlinks
  do
    realDir=$(readlink -f $entry)
    for str in "${CONFIGFOLDER[@]}"
    do
      if [[ "$realDir" = *"$str"* ]]; then
        sudo \cp "$realDir" "./$str/"
      fi
    done
  done
fi


if [ "$1" = "configuration" ]; then
  if [ -z "$2" ]; then 
    nixospath = "/etc/nixos"
    sudo cp ../configuration.nix "$nixospath"
    sudo cp ../hardware-configuration.nix "$nixospath"
    sudo cp ../tlp.nix "$nixospath"
    sudo cp ../pipewire.nix "$nixospath"
  else
    nixospath = "$2"
    sudo cp ../configuration.nix "$nixospath"
    sudo cp ../hardware-configuration.nix "$nixospath"
    sudo cp ../tlp.nix "$nixospath"
    sudo cp ../pipewire.nix "$nixospath"
  fi
fi
