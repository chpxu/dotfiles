# dotfiles

This repository hosts my dotfiles and configs for various applications on NixOS. Heavily WIP and continually evolving.

I will try to remember to give credits and links where possible but I'll probably forget.

This repo will also be updated when I'm bothered

- [x] I should make a script doing things

## General To-Do

1. [] Make system configuration a flake

## How the repository is structured

Since getting more comfortable with NixOS and home-manager, I've been working towards a more declarative setup (for now, in home-manager only) where all config and text files are declared in `.nix` files. This means I will no longer be writing config files separately and then symlinking them to the appropriate destination. Instead, this will all happen at once.

The repository structure should look something like this (using a `YAML`-like representation):

```
{
  ".config" = {
    "nixpkgs" = {
      "common" = [
        # Anything common to all nix files, like theme colours
      ],
      "modules" = {
        "programName" = [
          "default.nix" "programName.nix" "xdg.nix" # Anything else
      },
      "overlays" = {
        "overlayName" = [
          # File for the overlay. used for things where I have a custom derivation
        ]
      },
      "config.nix",
      "home.nix",
      "flake.nix",
      "flake.lock",
      # Other files not in use
    }
  },
  "system" = {
    # This folder is for the system configuration/ This has not been flakified
  },
  "old" = {
    # This folder will mostly be for backup, since I have pretty much everything managed via home-manager and NUR
    # This folder now lives in a different branch.
  },
  "docs" = {
    # For the website. On pause whilst I significantly overhaul my repo
  },
  "Pictures" = [
    # Pictures I use
  ],
  "Screenshots" = [
    # SS for the repo
  ],
  install.sh
  # Other files
}
```

1. The `modules` subfolder of `nixpkgs` is a directory of folders containing configuration files.

- Each of these folders contains:
  1.  A `default.nix` file. This file imports all the other files in the folder, and is ready to be imported by `home.nix`. This is always present.
  2.  A `programName.nix` file and other files/folders. These host the actual configuration for the programs if they can be managed through nix/home-manager.
  3.  A `xdg.nix` file. This file is used to source files to the appropriate directory. In cases where there is no home-manager configuration for a program, this file will act as the configuration file. Of course for the `xdg` subfolder, `xdg.nix` is the configuration file.
  - I use `xdg.configFile` out of personal preference. I can directly control where I want XDG to point to, what files to create and so on.
  4. A `config` folder containing either source files or more nix files for configuration of the program. Directory of this structure depends on how I prefer to organise it. Need to be more consistent though.
  - I prefer `nix` files where I am able to use nix expressions to insert values to make life easier, otherwise I prefer `non .nix` config files where I do not need nix abstractions.

2. The `overlays` folder is a set of folders containing overlays. These will replace the various `overrideAttrs` I have in `home.nix` with something more flexible and cleaner, eventually...

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

## Themes, Icons and Colour Palette

These dotfiles use 2 themes.

1. The [Nord colour palette](https://nordtheme.com).
2. The GTK theme [Nordic](https://www.gnome-look.org/p/1267246/) by @EliverLara.
   Follow the instructions on the page to use the GTK3/4 theme.
3. I use the [Fira Code Retina Nerd](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode) and [Source Code Pro](https://github.com/adobe-fonts/source-code-pro) fonts. Both are TTFs.
4. I use the [Nordzy](https://github.com/alvatip/Nordzy-icon) icon theme.
5. I use [Nordzy-cursors](https://www.gnome-look.org/p/1571937) as my cursor theme.

## Applications

These are the main applications and programs I use. Everything has been installed from`nixos-unstable` by default unless mentioned otherwise. WIP

### Applications

- firefox-wayland
- thunderbird-wayland
- gimp
- inkscape
- vscode (must fix python global env - import resolution fails)
- neovim (NEED TO FIX)
- discord-canary
- betterdiscordctl
- mpv
- imv
- rnote (nice to use, but memory intensive and scrolling lags on touch input. doesn't crash though!)
- xournalpp (liked to crash on wayfire, haven't tested on hyprland) (Custom derivation. See my [repo](https://github.com/chpxu/xournalpp))
- zathura
- libreoffice-fresh
- osu-lazer (nix-gaming flake)

### Environment programs

Applications or programs which affect my workspace

- ~~wayfire~~ (phasing out for Hyprland) (custom derivation to use `v0.7.4` for `src` instead)
- ~~wcm, wf-config~~ (phasing out for Hyprland)
- Hyprland (This is my current WM and will be phasing out wayfire from daily use).
- hyprpaper
- waybar (built with `-Dexperimental=true`)
- swayidle
- swaylock-effects (Using [this fork](https://github.com/jirutka/swaylock-effects)) (installed via `configuration.nix` due to auth issue)
- mako
- bemenu (planning to phase this out once I figure out a nice way to make cliphist work with wofi)
- cliphist
- wofi
- ~~kanshi~~ (Will be phasing out due to move to Hyprland)
- wl-clipboard
- kitty
- zsh
- wvkbd (custom derivation to add theming. See my [repo](https://github.com/chpxu/wvkbd))

## Steps to use

1. Clone the repository to somewhere safe, e.g. `$HOME`:

```sh
git clone https://github.com/chpxu/dotfiles.git
cd ./dotfiles
```

2. Give `install.sh` permissions (`sudo chmod u+x install.sh` or something)
3. Run `./install.sh`

This script will erase everything in `/etc/nixos` so please back up!!

### Firefox

Assuming Firefox is installed, follow these instructions:

1. Enable the extensions. This is due to how Firefox handles extension side-loading.
2. In the `Tab Center Reborn` extension preferences, copy and paste the contents of `./.config/nixpkgs/modules/firefox/config/tabCenterReborn-chpxu.css` inside the input box for Custom CSS.
3. Ensure Custom CSS/Styles whatever checkbox is enabled and restart firefox (or the extension).

Credits to @ranmaru22 for the` verticaltabs.css` and the [setup](https://github.com/ranmaru22/firefox-vertical-tabs) and credits to FILL_IN for the `oneline.css`.

Both CSS files have had my own slight modifications. To edit `userChrome.css` or `userContent.css`, see `firefox.nix` and appropriate subdirectories (an absolute mess right now).

#### To-Do

- [ ] Fix errors in certain `about:` pages. This is pretty much done. There are a few minor changes to some pages that must be done, but the theming is much more consistent and less broken.
- [x] The hover effect on the Tab Center Reborn is not of the correct colour.
- [] Attempt to configure extensions declaratively. (BIG)

### Thunderbird

TBD.

#### To-Do

- [ ] Learn to theme Thunderbird with `userChrome`
- [ ] Theme the rest of the UI and fix other colours

### Waybar, Wayfire, Swaylock, swayidle, wofi

Nothing else should need to be done if everything was copied correctly I think.

- [x] Swaylock does not work unless it is a system package. This is a known upstream issue.

### VSCode

Self-advertisement: install my theme [Firefox Quantum Themes](https://marketplace.visualstudio.com/items?itemName=beastdestroyer.firefox-quantum-themes) :)

#### To-Do

- [x] Add the settings and extensions I use to `home.nix`
- [ ] I plan to make my own Nord theme soon, after I update my theme to 2.0.0.

### Xournal++

The `home-manager switch` should be good to go.

#### To-Do

- [x] The background on the sidebar content is incorrect.
- [x] Check settings have been applied. Achieved with symlinking.

### Discord

NOTE: theming the main Discord client or using third-party client is against ToS and if discovered, could get your account banned. Do this at your own risk.

1. Install [BetterDiscord](https://betterdiscord.app/)
2. Ensure the CSS files in `./.config/BetterDiscord/themes` lie in the same directory but in your `$HOME`.
3. Enable the `nord-zelk` theme.

Credits to @schnensch0 for the [Zelk](https://github.com/schnensch0/zelk) theme which I modified.

#### To-Do

- [ ] Further modifications to make the theme consistent in colour.
- [ ] BetterDiscord actually starts everytime.

### Inkscape

1. Ensure the GTK Nordic theme is installed.
2. In Inkscape, head to _Edit > Preferences > Interface > Theming_ and set the theme to Nordic.

### GIMP

1. Copy the files in the repo to the same location in your home. If the copying above was done correctly, this should be fine.
2. In GIMP, go to _Edit > Preferences > Interface > Theme_ and select the theme containing the Nord styling.

Note: I have the Icon theme set to `Symbolic - High Contrast`.

#### To-Do

- [ ] Wayland when
