# dotfiles

This repository hosts my dotfiles and configs for various applications on NixOS. Heavily WIP and continually evolving.

I will try to remember to give credits and links where possible but I'll probably forget.

This repo will also be updated when I'm bothered

- [x] I should make a script doing things

## General To-Do

1. [ ] Make system configuration a flake (WIP)

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
- vscode (submodule resolution fails)
<!-- - neovim (NEED TO FIX) -->
- discord-canary
- betterdiscordctl
- mpv
- imv
- rnote (nice to use, but memory intensive and scrolling lags on touch input. doesn't crash though!)
- xournalpp (crash haven) (Custom derivation. See my [repo](https://github.com/chpxu/xournalpp))
- zathura
- libreoffice-fresh
- osu-lazer

### Environment programs

Applications or programs which affect my workspace

- Hyprland
- hyprpaper
- waybar (built with `-Dexperimental=true`)
- swayidle
- swaylock-effects (Using [this fork](https://github.com/jirutka/swaylock-effects)) (installed via `configuration.nix` due to auth issue)
- mako
- bemenu (planning to phase this out once I figure out a nice way to make cliphist work with wofi)
- cliphist
- wofi
- wl-clipboard
- kitty
- zsh
- wvkbd (custom derivation to add theming. See my [repo](https://github.com/chpxu/wvkbd))
- nano

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
<!-- 
Credits to @ranmaru22 for the` verticaltabs.css` and the [setup](https://github.com/ranmaru22/firefox-vertical-tabs) and credits to FILL_IN for the `oneline.css`.

Both CSS files have had my own slight modifications. To edit `userChrome.css` or `userContent.css`, see `firefox.nix` and appropriate subdirectories (an absolute mess right now). -->

#### To-Do

- [ ] Fix theming. Going for a much cleaner look.
- [ ] Multiple profiles, rather than using one profile and container tabs for better separation
- [x] The hover effect on the Tab Center Reborn is not of the correct colour.
- [ ] Attempt to configure extensions declaratively. (BIG)

### Thunderbird

TBD.

#### To-Do

- [ ] Learn to theme Thunderbird with `userChrome`
- [ ] Theme the rest of the UI and fix other colours

### VSCode

Self-advertisement: install my theme [Firefox Quantum Themes](https://marketplace.visualstudio.com/items?itemName=beastdestroyer.firefox-quantum-themes) :)

#### To-Do

- [x] Add the settings and extensions I use to `home.nix`
- [ ] I plan to make my own Nord theme soon, after I update my theme to 2.0.0.

### Discord

NOTE: theming the main Discord client or using third-party client is against ToS and if discovered, could get your account banned. Do this at your own risk.

1. Install [BetterDiscord](https://betterdiscord.app/)
2. Ensure the CSS files in `./.config/BetterDiscord/themes` lie in the same directory but in your `$HOME`.
3. Enable the `nord-zelk` theme.

Credits to @schnensch0 for the [Zelk](https://github.com/schnensch0/zelk) theme which I modified.

#### To-Do

- [ ] Further modifications to make the theme consistent in colour.
- [ ] BetterDiscord actually starts everytime.

### GIMP

1. Copy the files in the repo to the same location in your home. If the copying above was done correctly, this should be fine.
2. In GIMP, go to _Edit > Preferences > Interface > Theme_ and select the theme containing the Nord styling.

Note: I have the Icon theme set to `Symbolic - High Contrast`.

## Configuration Deep Dive

This section is more information about the configuration, mainly for those who want to extend/use this configuration (though you're probably better off using Misterio77's boilerplate).

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

#### Roadmap

- [ ] Explore decomposing programs into _bundles_. Bundles consist of a list of programs. Current idea is:
  - `env` for programs which set-up my display and system (e.g. Hyprland, wofi).
  - `daily` for programs to do day-to-day tasks (e.g. LibreOffice, Thunderbird)
  - `dev` for development purposes: python, front-end web development, vscode-extensions (finally)
  - `misc` is self-explanatory
- Properly parse inputs down to every nix file, to reduce the use of stray `import` statements

TBD
