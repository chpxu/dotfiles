# dotfiles
This repository hosts my dotfiles and configs for various applications on Void Linux. I cannot guarantee this will work on another linux distribution (but with appropriate modifications, it should). These dotfiles are WIP (i.e., not every application is themed as I want them to be).

I will try to remember to give credits and links where possible but I'll probably forget.

This repo will also be updated when I'm bothered
- [ ] I should make a script copying the relevant files 

## Screenshots
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
- Unfortunately GIMP (and Discord) is running in XWayland Mode :(
- The yellow box in Zathura is the select colour.
## Themes, Icons and Colour Palette
These dotfiles use 2 themes. 
1. The [Nord colour palette](https://nordtheme.com).
2. The GTK theme [Nordic](https://www.gnome-look.org/p/1267246/) by @EliverLara.
Follow the instructions on the page to use the GTK3/4 theme.
3. I use the [Fira Code Retina Nerd](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode) and [Source Code Pro](https://github.com/adobe-fonts/source-code-pro) fonts. Both are TTFs.
4. I use the [candy-icons](https://www.gnome-look.org/p/1305251/) icon theme.
5. I use [Nordzy-cursors](https://www.gnome-look.org/p/1571937) as my cursor theme.

I haven't been bothered to theme GTK2 (who uses it other than GIMP stable lol). Copying stuff from `gtk-2.0` into relevant GTK2 apps' themes folder seems to work.

~~I wasn't satisfied with any Nordic GTK2 themes, and so for a GTK2/3 compatible theme, I really enjoy [Olympic-Dark](https://www.gnome-look.org/p/1302313). BTW Olympic Dark is still very nice!~~

## Applications
These are the main applications and programs I use. Almost everything has been installed from the void repositories or with `xbps-src`. It is necessary to enable the [nonfree repos](https://docs.voidlinux.org/xbps/repositories/index.html) on Void, or the equivalent on your distro. 

### Productivity Applications
Applications or programs which I use for my work and studies
- firefox (void repos)
- GIMP (void repos)
- Inkscape (void repos)
- Thunderbird (website)
- VSCode Insiders (from the website)
- Discord (from `xbps-src` as `discord`)
- Microsoft Teams (from `xbps-src` as `teams-bin`)
- mpv (void repos)
- imv (void repos)
- zathura (void repos)
- xournalpp (void repos)
- LibreOffice (void repos)
### Environment programs
Applications or programs which setup my workspace
- wayfire and wcm (void repos) 
- waybar (void repos)
- swayidle (void repos)
- [swaylock-effects](https://github.com/mortie/swaylock-effects) (built from repo). Note: I got many errors relating to `omp.h`  not found. Install `libgomp-devel` (if using GCC) or `libomp-devel` from the void repos and compile.
- mako (void repos)
- bemenu (void repos)
- [cliphist](https://github.com/sentriz/cliphist/releases/) (binary from github)
- nwg-launchers (void repos)
- kanshi (void repos)
- wl-clipboard (void repos)
- alacritty
- zsh
- virtboard (from repo on GitLab. Possibly to be replaced with `maliit`)

## Steps to use
1. Clone the repository to somewhere safe, e.g. `$HOME`:
```sh
git clone https://github.com/chpxu/dotfiles.git
cd ./dotfiles
```

2. Copy all files and folders inside `./.config` to `$HOME/.config`:
```sh
cp -r ./.config/* $HOME/.config
```
4. It is now time to install the themes `Nordzy-cursors` and `candy-icons` to `$HOME/.icons`. Follow their GitHub pages linked at the top for instructions.

Install the Nordic GTK theme to `$HOME/.themes`

Make sure to enable all the themes with `gsettings`
```
gsettings set org.gnome.desktop.interface cursor-theme Nordzy-cursors
gsettings set org.gnome.desktop.interface icon-theme candy-icons
gsettings set org.gnome.desktop.interface gtk-theme "Nordic"
gsettings set org.gnome.desktop.wm.preferences theme "Nordic"
```
It may be necessary to make sure the directory for `candy-icons` is named `candy-icons` exactly.

5. Install all programs you want above. You can do this beforehand as well, it literally doesn't matter.
```sh
sudo xbps-install -y -f firefox gimp inkscape thunderbird mpv imv zathura wayfire wcm waybar swayidle swaylock mako bemenu nwg-launchers kanshi wl-clipboard lf alsa alsa-tools
```
Ones which aren't directly in the void repositories or must be built from `xbps-src` are denoted.
  - Note: the `vscode` package from the void repos installs the stable version of `Code - OSS`. There is no difference AFAIK in terms of theming wise for these dotfiles.
6. Copy from the repo, the entire `Pictures` to `$HOME`:
```sh
cp -r /path/to/dotfiles/Pictures/* $HOME/Pictures
```
7. Now there are application specific customisations. Not all of them are done.

### Firefox
Assuming Firefox is installed, follow these instructions:
1. Locate your `.mozilla` folder. This is by default in `$HOME`. Enter into the `firefox`  folder in the repo.
```sh
cd /path/to/dotfiles/.mozilla/firefox
```
2. Locate your firefox profile that you want to theme. This is very important. In Firefox, go to `about:profiles` and find which profile is the default one. Then take note of the `*.default-default` directory (i.e., next to "Root Directory"). It will be a random combination of symbols.

There should also be a `.default` folder that is associated with the `.default-default`. I don't use this folder.

1. In Firefox, install the [Tab Center Reborn](https://addons.mozilla.org/en-GB/firefox/addon/tabcenter-reborn/) extension.

2. In `about:addons`, navigate to Tab Center Reborn's Preferences. Enable `Compact Mode` and `Custom Stylesheet`.

In the repo, open the file `.mozilla/firefox/this.default-default/tabCenterReborn.css`. Copy all its content into the `Custom Stylesheet` editor.

Click `Save CSS` and you can leave that page.

5. Copy everything in `this.default-default` into your `.default-default` folder:
```sh
cd /path/to/dotfiles
cp -r ./.mozilla/firefox/this.default-default/* /path/to/your/.default-default
```
6. In `about:config` in Firefox, set `toolkit.legacyUserProfileCustomizations.stylesheets` to `true`.
7. Follow instructions [here](https://github.com/EliverLara/firefox-nordic-theme) to enable EliverLara's Firefox Nordic Theme.
8. Install this [Nordic Firefox theme](https://addons.mozilla.org/en-US/firefox/addon/nord-polar-night-theme/) from the Addons store
9. Restart Firefox

Credits to @ranmaru22 for the` verticaltabs.css` and the [setup](https://github.com/ranmaru22/firefox-vertical-tabs) and credits to  FILL_IN for the `oneline.css`.

Both CSS files have had my own slight modifications.

#### To-Do
- [ ] Fix errors in certain `about:` pages. This may never be resolved however and will have to cope with defaults.
- [ ] The hover effect on the Tab Center Reborn is not of the correct colour.

Make sure `MOZ_ENABLE_WAYLAND=1` is set, or in the `.desktop` file for Firefox, replace the `Exec=/path/to/firefox/bin.` line with `Exec=env MOZ_ENABLE_WAYLAND=1 /path/to/firefox/bin `
### Thunderbird
1. Install Thunderbird 102, which will be downloaded as a `.tar.bz2` file. Extract this to somewhere safe - we will always launch it from there. Currently the Void repos only have version `91.9`.
2. Install the Nord theme from [addons.thunderbird.com](addons.thunderbird.com).
3. Go to _Settings > General_ and scroll all the way down to the bottom, to _Config Editor_.
4. Change the `toolkit.legacyUserProfileCustomizations.stylesheets` to `true`.
5. Like in Firefox, get your profile directory and copy everything in its chrome folder to your thunderbird's chrome directory. (currently this doesn't have any effect but helps for further work, probably will write something from scratch as I figure out how to theme thunderbird).

Make sure `MOZ_ENABLE_WAYLAND=1` is set, or in the `.desktop` file for Thunderbird, replace the `Exec=/path/to/thunderbird/bin.` line with `Exec=env MOZ_ENABLE_WAYLAND=1 /path/to/thunderbird/bin `

#### To-Do
- [ ] Learn to theme Thunderbird with `userChrome`
- [ ] Theme the rest of the UI and fix other colours
### Waybar, Wayfire, Swaylock, swayidle, nwg-launchers
Nothing else should need to be done if everything was copied correctly I think. 
<!-- ### swaylock
### swayidle -->
### VSCode
1. Ensure that VSCode has already created `$HOME/.config/Code`. It might not be `Code`, but `Code - OSS` or `Code - Insiders` instead.
2. Copy the files in `dotfiles/Code - Insiders` to the same files in your home config
3. Install the Nord extension by Arctic Ice Studio and enable it.

Self-advertisement: install my theme [Firefox Quantum Themes](https://marketplace.visualstudio.com/items?itemName=beastdestroyer.firefox-quantum-themes) :)

- [ ] I plan to make my own Nord theme soon, after I update my theme to 2.0.0.

### Xournal++
1. Follow the `Installation` steps at @juansegaes's [XournalPP Nordic theme](https://github.com/juansegaes/xournalpp-nord).
2. In Xournal++, enable the Nord theme in _View > Toolbars > Nord_<Dark|Light>_
3. Go to _Edit > Preferences_ and change the following:
   1. Have `Dark Theme` enabled.
   2. In the _View_ tab, change `Border Color` to `#bf616a`.
   3. In the same tab, change `Background color between pages` to `#2e3440`.
   4. In the same tab, change `Selection color` to `#5e81ac`.
   5. In the same tab, if you have `Cursor icon for pen` _not_ set to `No icon`, you have extra settings. 
      1. Change `Circle color` to  `#ebcb8b` and drag the opacity slider to your preference
      2. Change `Border color` to `#81a1c1`, again dragging the opacity slider to your preference.
4. Now go to `Journal > Configure Page Template` and set the `Background Color` to `#2e3440`.
5. We copy the xournal CSS file. Note: keep a backup of this file - when xournal updates, the CSS file gets overwritten. I will try to keep up with updates. This CSS file is verified for Xournal++ `>= 1.1.0`.
```sh
sudo cp dotfiles/.config/xournalpp/xournalpp.css /usr/share/xournalpp/ui/xournalpp.css
```
Make sure to restart Xournal++ for the changes to take effect.
#### To-Do
- [x] The background on the sidebar content is incorrect.
### zsh
1. Install and enable `zsh`, `zsh-syntax-highlighting` and `oh-my-zsh`
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
2. In Inkscape, head to _Edit > Preferences > Interface > Themeing_ and set the theme to Nordic.

### GIMP
1. In `$HOME/.config/GIMP/<x>.<y>/themes`, make a directory which is your theme name. Mine is called `Nord Dark`.
2. From EliverLara's Nordic GitHub linked above, download and extract the repo to somewhere else safe. 
3. Copy all the contents inside `gtk-2.0` to your folder in your GIMP themes directory (Step 1). For example, assuming we extracted the Nordic repo to `$HOME`:
```sh
sudo cp -r $HOME/Nordic/gtk-2.0/* '$HOME/.config/GIMP/2.10/themes/Nord Dark'
```
4. In GIMP, go to _Edit > Preferences > Interface > Theme_ and select the theme containing the Nord styling.
  
Note: I have the Icon theme set to `Symbolic - High Contrast`.
#### To-Do
- [ ] The hover effects are too light.
- [ ] Some text is black.
