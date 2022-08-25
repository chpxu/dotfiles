# dotfiles
This repository hosts my dotfiles and configs for various applications on NixOS. Heavily WIP and continually evolving.

I will try to remember to give credits and links where possible but I'll probably forget.

This repo will also be updated when I'm bothered
- [ ] I should make a script copying the relevant files (WIP)

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
These are the main applications and programs I use. Everything has been installed from `nixos-22.05` or `nixos-unstable` with preference to unstable. WIP.
### Productivity Applications
- firefox-wayland (`unstable`)
- gimp (2.10.32) (`unstable`)
- inkscape (`unstable`)
- thunderbird-wayland (`unstable`)
- vscode (`unstable`)
- discord-canary (`unstable`)
- mpv (`unstable`)
- imv (`unstable`)
- zathura (`22.05`)
- xournalpp (Custom derivation. See `$HOME/.config/home.nix`)
- betterdiscordctl (`unstable`)
<!-- - LibreOffice (void repos) -->
### Environment programs
Applications or programs which setup my workspace
- wayfire (custom derivation to use `v0.7.4` for `src` instead)
- wcm, wf-config (`unstable`)
- waybar (`unstable`)
- swayidle (`unstable`)
- swaylock-effects (`unstable`)
- mako (`unstable`)
- bemenu (`unstable`)
- cliphist (`unstable`)
- wofi (`unstable`)
- kanshi (`unstable`)
- wl-clipboard (`unstable`)
- kitty (`unstable`)
- zsh (`unstable`)
- wvkbd (`unstable`)

## Steps to use
1. Clone the repository to somewhere safe, e.g. `$HOME`:
```sh
git clone https://github.com/chpxu/dotfiles.git
cd ./dotfiles
```
2. Move `configuration.nix` and `hardware-configuration.nix` to `/etc/nixos/` (or wherever you have it installed). Ensure `hardware-configuration.nix` is correct for your system!
3. Then copy all files and folders inside `./.config` to `$HOME/.config`:
```sh
cp -r ./.config/* $HOME/.config
```
4. Run `sudo nixos-rebuild switch`. Reboot to be sure and check everything is installed.
5. Copy from the repo, the entire `Pictures` to `$HOME`:
```sh
cp -r /path/to/dotfiles/Pictures/* $HOME/Pictures
```
6. Run `home-manager switch`. Reboot to be sure and check everything is installed and copied to nix store. You may get warnings about files being the same or skipping delete. That is fine. If you get any errors (usually file conflicts), resolve as necessary (usually deleting the file works).

Some things to do here: `betterdiscordctl` likes to not enable itself after restart/rebuild. Running TBD as a login script is the solution for now.

This section should eventually be handled automatically by the install script in `./scripts/copy.sh`, but that is WIP.
Now there are application specific customisations. Not all of them are complete.

Note: channels. I am subscribed to nixpkgs-unstable, nixos-22.05 and home-manager master
### Firefox
Assuming Firefox is installed, follow these instructions:
1. Enable the extensions. This is due to how Firefox handles extension side-loading.
2. In the `Tab Center Reborn` extension preferences, copy and paste the contents of `./.mozilla.firefox/chrome/tabCenterReborn-chpxu.css`  inside the input box for Custom CSS
3. Ensure Custom CSS/Styles whatever checkbox is enabled and restart firefox (or the extension). 

Credits to @ranmaru22 for the` verticaltabs.css` and the [setup](https://github.com/ranmaru22/firefox-vertical-tabs) and credits to  FILL_IN for the `oneline.css`.

Both CSS files have had my own slight modifications. To edit `userChrome.css` or `userContent.css`, see `firefox.nix`.

#### To-Do
- [ ] Fix errors in certain `about:` pages. This is pretty much done. There are a few minor changes to some pages that must be done, but the theming is much more consistent and less broken.
- [x] The hover effect on the Tab Center Reborn is not of the correct colour.

### Thunderbird
TBD.
#### To-Do
- [ ] Learn to theme Thunderbird with `userChrome`
- [ ] Theme the rest of the UI and fix other colours
### Waybar, Wayfire, Swaylock, swayidle, wofi
Nothing else should need to be done if everything was copied correctly I think. 

- [x] Swaylock does not work unless it is a system package. This is a known upstream issue. 
### VSCode
1. Ensure that VSCode has already created `$HOME/.config/Code`. It might not be `Code`, but `Code - OSS` or `Code - Insiders` instead.
2. Copy the files in `dotfiles/Code` to the same locations in your home

Self-advertisement: install my theme [Firefox Quantum Themes](https://marketplace.visualstudio.com/items?itemName=beastdestroyer.firefox-quantum-themes) :)

#### To-Do
- [x] Add the settings and extensions I use to `home.nix`
- [ ] I plan to make my own Nord theme soon, after I update my theme to 2.0.0.

### Xournal++
The `home-manager switch` should be good to go.
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