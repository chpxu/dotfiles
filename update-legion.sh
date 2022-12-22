cd $HOME/dotfiles
nix flake update
# update system
sudo nixos-rebuild switch --flake .#legion --impure --show-trace
# update home
home-manager switch --flake .#chunix@legion --impure --show-trace
