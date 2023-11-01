# dotfiles

This repository hosts my dotfiles and configs for various applications on NixOS. Heavily WIP and continually evolving.

I will try to remember to give credits and links where possible but I'll probably forget.

## How the repository is structured

This structure was heavily inspired, and has some code taken from [Misterio77's nix-starter-configs](https://github.com/Misterio77/nix-starter-configs). This was extremely helpful in getting me to have a refactored and cleaner NixOS setup.

```
.
├── hm/
│   ├── common/
│   │   ├── packages/
│   │   │   └── # A set of common packages I share across my users where no configuration is required
│   │   └── modules/
│   │       └── # A set of common configurations for programs I share across my users
│   ├── chunix/
│       ├── home.nix
│       └── ...
│
├── overlays # a set of overlays
├── system/
│   ├── common/
│   │   └── # A set of common packages/configurations I share across my systems
│   ├── yoga # configuration for my Yoga C940
│   └── legion # Configuration for my Legion 5 Pro Gen 7 (WIP)
├── docs/
│   └── ...
├── Pictures/
│   └── ...
├── flake.nix
├── flake.lock
└── install.sh
```

## Screenshots

New SS coming soon.

<!-- ![Desktop](https://github.com/chpxu/dotfiles/blob/void/Screenshots/desktop.png)
![Firefox](https://github.com/chpxu/dotfiles/blob/void/Screenshots/firefox.png)
![nwggrid](https://github.com/chpxu/dotfiles/blob/void/Screenshots/nwggrid.png)
![VSCode](https://github.com/chpxu/dotfiles/blob/void/Screenshots/vscode.png)
![Xournal++](https://github.com/chpxu/dotfiles/blob/void/Screenshots/xournalpp.png)
![Alacritty](https://github.com/chpxu/dotfiles/blob/void/Screenshots/alacritty.png)
![Zathura](https://github.com/chpxu/dotfiles/blob/void/Screenshots/zathura.png)
![GIMP](https://github.com/chpxu/dotfiles/blob/void/Screenshots/gimp.png)
![Inkscape](https://github.com/chpxu/dotfiles/blob/void/Screenshots/inkscape.png)
![Thunderbird](https://github.com/chpxu/dotfiles/blob/void/Screenshots/thunderbird.png) -->
<!--
Notes:
- Unfortunately GIMP is running in XWayland Mode :(
- The yellow box in Zathura is the select colour. -->

## Installation Instructions

This setup uses home-manager as a standalone module, and so must be installed separately, alongside `git` to get the repo. Alternatively, one may have the repo on external storage, in which case skip to Step 4.

1. Download and Install NixOS. No need to configure channels or extra users or anything (though you may wish to create a minimal, dummy user to check everything works, beware of bad reproducibility!)
2. Install git temporarily and get the repo into current directory: `nix-shell -p git --run "git clone https://github.com/chpxu/dotfiles.git"`
3. `cd` into `dotfiles`
4. Run `install.sh`. You may need to give permissions to run as root.

## Themes, Icons and Colour Palette

These dotfiles uses the Nord theme.

1. The [Nord colour palette](https://nordtheme.com).
2. The GTK theme [Nordic](https://www.gnome-look.org/p/1267246/) by @EliverLara.
   Follow the instructions on the page to use the GTK3/4 theme.
3. I use the [Fira Code Retina Nerd](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode) and [Source Code Pro](https://github.com/adobe-fonts/source-code-pro) fonts. Both are TTFs.
4. I use the [Nordzy](https://github.com/alvatip/Nordzy-icon) icon theme.
5. I use [Nordzy-cursors](https://www.gnome-look.org/p/1571937) as my cursor theme.

## Things todo before/after installing

1. Delete the networking settings and use your own.
2. Adjust `flake.nix` to have correct users and hostnames. Probably will have to adjust installer script too

## Programs and Applications

These are the main applications and programs I use. Everything has been
installed from `nixos-unstable` by default unless mentioned otherwise. WIP.

### Applications

- [firefox-dev-edition](https://www.mozilla.org/en-GB/firefox/developer/)
- [gimp](https://gimp.org)
- [inkscape](https://inkscape.org)
- [vscode](https://code.visualstudio.com)
- [discord-canary](https://discord.com)
- [mpv](https://mpv.io)
- [imv](https://sr.ht/~exec64/imv/)
- [rnote](https://github.com/flxzt/rnote)
- [zathura](https://pwmt.org/projects/zathura/)
- [libreoffice](https://libreoffice.org) (fresh branch)
- [zotero](https://zotero.org)
- [logseq](https://logseq.com)
- [pdfarranger](https://github.com/pdfarranger/pdfarranger)

### Environment programs

Applications or programs which affect my workspace

- [Hyprland](https://hyprland.org)
- [hyprpaper](https://github.com/hyprwm/hyprpaper)
- [waybar](https://github.com/Alexays/Waybar) (built with `-Dexperimental=true`)
- [swayidle](https://github.com/swaywm/swayidle)
- [swaylock-effects](https://github.com/jirutka/swaylock-effects) (jirutka fork)
- [mako](https://github.com/emersion/mako)
- [cliphist](https://github.com/sentriz/cliphist) + [wl-clipboard](https://github.com/bugaevc/wl-clipboard)
- [rofi-wayland](https://github.com/lbonn/rofi#wayland-support)
- [kitty](https://sw.kovidgoyal.net/kitty/)
- [zsh](https://zsh.org) + [starship](https://starship.rs)
- wvkbd (custom derivation to add theming. See my [repo](https://github.com/chpxu/wvkbd))
- [nano](https://nano-editor.org)
- [direnv](https://direnv.net)

## Configuration Deep Dive

This section is more information about the configuration, mainly for those who want to extend/use this configuration (though you're probably better off using Misterio77's boilerplate).

### Why have an installer script?

Why not? Nix makes it easy to have a common configuration that is easy to _install_ after running a bunch of commands. The install script exists to have, in some ways, a much simpler interface to the flake. Please do check it to know what is happening (those commands are essential!)

### `flake.nix` structure

The `flake.nix` looks like quite a mess right now, most of it is due to my own inability to maintain and create a flexible, modular, declarative setup. There are however, multiple important sections as described by the NixOS wiki on [flake schema](https://nixos.wiki/wiki/Flakes):

1. Description. Self-explanatory. Edit it to whatever `string` you want.
2. `inputs` attribute set contain the flake inputs. Where possible, I have tried to use flake inputs or overlays for as many (environment) programs as possible.
3. A bunch of `let` bindings. Namely:
   - `system`, `user`, `pkgs` for some easy reusable keywords
   - `colour-palette` which is the file containing the RGB hex codes for the Nord theme.
   - `mkHomeConfiguration` a function which creates a home for a user and hostname. Creates a full-fledged user based off my specifications
   - `mkSystemConfiguration` a function which creates a NixOS system with given hostname, users and minimal modules.
4. `outputs`. What the flake returns and allows you to access.
