#!/bin/sh
# This basic shell script copies files to and from appropriate destinations in $HOME and the repository folder. 
# Ensure this script has executable permissions with chmod u+x copy.sh
# Copying to your $HOME means you should execute ./copy.sh dotfiles
#   1. this will replace any configurations you currently use. Back them up!
#   2. This also runs home-manager switch
# Executing "./copy.sh nixfiles" will attempt to:
#   1.  Search your $HOME/.config for the appropriate folders
#   2.  Find all symlinks and trace them through the nix store
#   3. Copy the original files to the dotfiles repository, replacing files in the repo locally and thus allowing you to make your own changes


# Executing ``./copy.sh dotfiles configuration "/path/to/copy"`` will copy configuration.nix, hardware-configuration.nix, tlp.nix, pipewire.nix to your desired folder. By default this is assumed to be /etc/nixos.
# Please edit hardware-configuration.nix with your hardware before building!
# The script auto runs nixos-rebuild switch for you, if you supply the configuration argument to the script
# This script requires an internet connection to connect to packages and override some packages to my own repositories.
# This script is a WIP, as is everything else in this repository
# This script requires sudo permissions for everything except the plain dotfiles argument. Please ensure you read through the script (and everything else in the repo) to make sure nothing bad gets through.

# Writing copying to home section
# This will overwrite your current configurations, please make sure you have them backed up if you care!
if [ "$1" = "dotfiles" ]; then
  cp -r ../.config $HOME/
  defaultDir=$(find $HOME/.mozilla/firefox -name *.default)
  cp -r ../.mozilla/firefox/chrome "$defaultDir/"
  cp -r ../Pictures $HOME/

  if [ "$2" = "configuration" ]; then
    if [ -z "$3" ]; then 
      nixospath = "/etc/nixos"
      sudo cp ../configuration.nix "$nixospath"
      sudo cp ../hardware-configuration.nix "$nixospath"
      sudo cp ../tlp.nix "$nixospath"
      sudo cp ../pipewire.nix "$nixospath"
    else
      nixospath = "$3"
      sudo cp ../configuration.nix "$nixospath"
      sudo cp ../hardware-configuration.nix "$nixospath"
      sudo cp ../tlp.nix "$nixospath"
      sudo cp ../pipewire.nix "$nixospath"
    fi
    sudo nixos-rebuild switch
  fi
  home-manager switch
fi

# Attempt to find original files from symlinks in nix store, to copy over original files
declare -a CONFIGFOLDER=("BetterDiscord" "kanshi" "kitty" "mako" "nano" "neofetch" "swaylock" "waybar" "wlogout" "wofi"  "zathura")

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



