# dotfiles
This repository hosts my dotfiles and configs for various applications on NixOS. Heavily WIP.

I will try to remember to give credits and links where possible but I'll probably forget.

This repo will also be updated when I'm bothered
- [ ] I should make a script copying the relevant files 

## Screenshots
these are out of date but more or less representative 
![Desktop](https://github.com/chpxu/dotfiles/blob/void/Screenshots/desktop.png)
![Firefox](https://github.com/chpxu/dotfiles/blob/void/Screenshots/firefox.png)
![nwggrid](https://github.com/chpxu/dotfiles/blob/void/Screenshots/nwggrid.png)
![VSCode](https://github.com/chpxu/dotfiles/blob/void/Screenshots/vscode.png)
![Xournal++](https://github.com/chpxu/dotfiles/blob/void/Screenshots/xournalpp.png)
![Alacritty](https://github.com/chpxu/dotfiles/blob/void/Screenshots/alacritty.png)
![Zathura](https://github.com/chpxu/dotfiles/blob/void/Screenshots/zathura.png)
![GIMP](https://github.com/chpxu/dotfiles/blob/void/Screenshots/gimp.png)
![Inkscape](https://github.com/chpxu/dotfiles/blob/void/Screenshots/inkscape.png)
![Thunderbird](https://github.com/chpxu/dotfiles/blob/void/Screenshots/thunderbird.png)

Notes:
- Unfortunately GIMP is running in XWayland Mode :(
- The yellow box in Zathura is the select colour.
## Themes, Icons and Colour Palette
These dotfiles use 2 themes. 
1. The [Nord colour palette](https://nordtheme.com).
2. The GTK theme [Nordic](https://www.gnome-look.org/p/1267246/) by @EliverLara.
Follow the instructions on the page to use the GTK3/4 theme.
3. I use the [Fira Code Retina Nerd](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode) and [Source Code Pro](https://github.com/adobe-fonts/source-code-pro) fonts. Both are TTFs.
4. I use the [Nordzy](https://github.com/alvatip/Nordzy-icon) icon theme.
5. I use [Nordzy-cursors](https://www.gnome-look.org/p/1571937) as my cursor theme.

## Applications
These are the main applications and programs I use. Everything has been installed from `nixos-22.05` or `nixos-unstable` with preference to unstable. WIP.
### Productivity Applications
- firefox-wayland (`unstable`)
- gimp (2.10.32) (`unstable`)
- inkscape (`unstable`)
- thunderbird-wayland (`unstable`)
- vscode (`unstable`)
- discord (`unstable`)
- mpv (`unstable`)
- imv (`unstable`)
- zathura (`unstable`)
- xournalpp (Custom derivation. See `$HOME/.config/nixpkgs`)
- betterdiscordctl (`unstable`)
<!-- - LibreOffice (void repos) -->
### Environment programs
Applications or programs which setup my workspace
- wayfire, wcm, wf-config (`22.05`)
- waybar (`unstable`)
- swayidle (`unstable`)
- swaylock-effects (`unstable`)
- mako (`unstable`)
- bemenu (`unstable`)
- cliphist (`unstable`)
- wofi (`unstable`)
- kanshi (`unstable`)
- wl-clipboard (`unstable`)
- alacritty (`unstable`)
- zsh (`unstable`)
- wlogout (`unstable`)
- wvkbd (`unstable`)

## Steps to use
1. Clone the repository to somewhere safe, e.g. `$HOME`:
```sh
git clone https://github.com/chpxu/dotfiles.git
cd ./dotfiles
```
2. Move `configuration.nix` to `/etc/nixos/configuration.nix` (or wherever you have it installed) and run `sudo nixos-rebuild switch`. Check everything worked (e.g., you have home-manager, user has zsh etc).
3. First move `home.nix` inside the repo to your `$HOME/.config/nixpkgs`, and in the terminal, run `home-manager switch`, which installs a lot of things. 
4. Once that is done, copy all files and folders inside `./.config` to `$HOME/.config`:
```sh
cp -r ./.config/* $HOME/.config
```
Some things to do here: `betterdiscordctl` likes to not enable itself after restart. Running TBD as a login script is the solution for now.
5. Copy from the repo, the entire `Pictures` to `$HOME`:
```sh
cp -r /path/to/dotfiles/Pictures/* $HOME/Pictures
```

Now there are application specific customisations. Not all of them are complete.

### Firefox
Assuming Firefox is installed, follow these instructions:
1. Locate your `.mozilla` folder. This is by default in `$HOME`. Enter into the `firefox`  folder in the repo.
```sh
cd /path/to/dotfiles/.mozilla/firefox
```
2. Locate your firefox profile that you want to theme. This is very important. In Firefox, go to `about:profiles` and find which profile is the default one. There should be a `.default` folder, and this is where we do our work.

1. In Firefox, install the [Tab Center Reborn](https://addons.mozilla.org/en-GB/firefox/addon/tabcenter-reborn/) extension.

2. In `about:addons`, navigate to Tab Center Reborn's Preferences. Enable `Compact Mode` and `Custom Stylesheet`.

3. In the repo, open the file `.mozilla/firefox/this.default-default/tabCenterReborn.css`. Copy all its content into the `Custom Stylesheet` editor. Click `Save CSS` and you can leave that page.

4. Copy everything in `this.default-default` into your `.default` folder:
```sh
cd /path/to/dotfiles
cp -r ./.mozilla/firefox/this.default-default/* /path/to/your/.default
```
5. In `about:config` in Firefox, set `toolkit.legacyUserProfileCustomizations.stylesheets` to `true`.
6. Follow instructions [here](https://github.com/EliverLara/firefox-nordic-theme) to enable EliverLara's Firefox Nordic Theme. Clone it inside the `chrome` folder  so it has a directory `firefox-nordic-theme`.
7. Install this [Nordic Firefox theme](https://addons.mozilla.org/en-US/firefox/addon/nord-polar-night-theme/) from the Add-ons store.
8. Restart Firefox.

Credits to @ranmaru22 for the` verticaltabs.css` and the [setup](https://github.com/ranmaru22/firefox-vertical-tabs) and credits to  FILL_IN for the `oneline.css`.

Both CSS files have had my own slight modifications.

#### To-Do
- [ ] Fix errors in certain `about:` pages. This may never be resolved however and will have to cope with defaults.
- [ ] The hover effect on the Tab Center Reborn is not of the correct colour.

### Thunderbird
TBD.
#### To-Do
- [ ] Learn to theme Thunderbird with `userChrome`
- [ ] Theme the rest of the UI and fix other colours
### Waybar, Wayfire, Swaylock, swayidle, wofi
Nothing else should need to be done if everything was copied correctly I think. 

### VSCode
1. Ensure that VSCode has already created `$HOME/.config/Code`. It might not be `Code`, but `Code - OSS` or `Code - Insiders` instead.
2. Copy the files in `dotfiles/Code` to the same locations in your home
3. Install the Nord extension by Arctic Ice Studio and enable it.

Self-advertisement: install my theme [Firefox Quantum Themes](https://marketplace.visualstudio.com/items?itemName=beastdestroyer.firefox-quantum-themes) :)

#### To-Do
- [ ] Add the settings and extensions I use to `home.nix`
- [ ] I plan to make my own Nord theme soon, after I update my theme to 2.0.0.

### Xournal++
1. When running `home-manager switch`, my custom build of Xournal++ will be installed. Its files currently live in `$HOME/.config/nixpkgs/xournalpp`.

Make sure to restart Xournal++ for the changes to take effect.
#### To-Do
- [x] The background on the sidebar content is incorrect.
- [ ] Check settings have been applied.
### Discord
NOTE: theming the main Discord client or using third-party client is against ToS and if discovered, could get your account banned. Do this at your own risk.

1. Install [BetterDiscord](https://betterdiscord.app/)
2. Ensure the CSS files in `./.config/BetterDiscord/themes` lie in the same directory but in your `$HOME`. 
3. Enable the `nord-zelk` theme.

Credits to @schnensch0 for the [Zelk](https://github.com/schnensch0/zelk) theme which I modified.

#### To-Do
- [ ]  Further modifications to make the theme consistent in colour.

### Inkscape
1. Ensure the GTK Nordic theme is installed.
2. In Inkscape, head to _Edit > Preferences > Interface > Theming_ and set the theme to Nordic.
### GIMP
1. Copy the files in the repo to the same location in your home. If the copying above was done correctly, this should be fine.
2. In GIMP, go to _Edit > Preferences > Interface > Theme_ and select the theme containing the Nord styling.
  
Note: I have the Icon theme set to `Symbolic - High Contrast`.
#### To-Do
- [ ] Wayland when