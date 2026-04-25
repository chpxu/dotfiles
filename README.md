# dotfiles

My dotfiles for NixOS. Based on `vic/den`. Personalised for gaming, software and scientific development.

## Hosts

- `saitama`: AMD Ryzen 5600X + RTX 5070 Ti
- `jingliu`: Intel + Nvidia optimus laptop
- `yoga`: Lenovo Yoga C940

## Programs and Applications

These are the main applications and programs I use. Everything has been
installed from `nixos-unstable` by default unless mentioned otherwise. WIP.

### Applications

- [firefox-dev-edition](https://www.mozilla.org/en-GB/firefox/developer/)
- [gimp 3.x](https://gimp.org)
- [inkscape](https://inkscape.org)
- [vscode-fhs](https://code.visualstudio.com)
- [discord-canary](https://discord.com)
- [mpv](https://mpv.io)
- [imv](https://sr.ht/~exec64/imv/)
- [rnote](https://github.com/flxzt/rnote)
- [zathura](https://pwmt.org/projects/zathura/)
- [libreoffice-fresh](https://libreoffice.org)
- [zotero](https://zotero.org)
- [logseq](https://logseq.com)
- [pdfarranger](https://github.com/pdfarranger/pdfarranger)
- [thunderbird](https://www.thunderbird.net)
- [bitwarden](https://bitwarden.com/)
- [yazi](https://yazi-rs.github.io/)
- [steam](https://store.steampowered.com/)
- [Mullvad](https://mullvad.net)

### Environment programs

Applications or programs which affect my workspace

- [Hyprland](https://hyprland.org)
  - Plugins: [hyprsplit](https://github.com/shezdy/hyprsplit).
- [wpaperd](https://github.com/danyspin97/wpaperd)
- [waybar](https://github.com/Alexays/Waybar) (built with `-Dexperimental=true`)
- [swayidle](https://github.com/swaywm/swayidle)
- [swaylock-effects](https://github.com/jirutka/swaylock-effects) (jirutka fork)
- [mako](https://github.com/emersion/mako)
- [cliphist](https://github.com/sentriz/cliphist) + [wl-clipboard](https://github.com/bugaevc/wl-clipboard)
- [rofi](https://github.com/lbonn/rofi#wayland-support)
- [kitty](https://sw.kovidgoyal.net/kitty/)
- [zsh](https://zsh.org) + [starship](https://starship.rs)
- [wvkbd](https://github.com/jjsullivan5196/wvkbd) (custom derivation to add theming. See my [repo](https://github.com/chpxu/wvkbd))
- [nano](https://nano-editor.org)
- [direnv](https://direnv.net)
- [dragon-drop](https://github.com/mwh/dragon)

<!-- # Getting Started Guide

Steps you can follow after cloning this template:

- Be sure to read the [den documentation](https://vic.github.io/den)

- Update den input.

```console
nix flake update den
```

- Edit [modules/hosts.nix](modules/hosts.nix)

- Build

```console
# default action is build
nix run .#igloo

# pass any other nh action
nix run .#igloo -- switch
```

- Run the VM

We recommend to use a VM develop cycle so you can play with the system before applying to your hardware.

See [modules/vm.nix](modules/vm.nix)

```console
nix run .#vm
``` -->
