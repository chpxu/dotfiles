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
│   └── ... # website for dotfiles
├── Pictures/
│   └── ...
├── flake.nix
├── flake.lock
└── install.sh
```

## Screenshots

TBD

## Installation Instructions

This NixOS setup integrates `home-manager` into the system configuration so that all users can simply be updated with `sudo nixos-rebuild switch .#<hostname>`.

1. Whether you're booting from scratch or not, you need `git` (or just have the repo locally). If you don't have git, you can temporarily invoke it with `nix-shell -p git --run "git clone https://github.com/chpxu/dotfiles"` and it will clone the repo into a folder called `dotfiles` in your present working directory.
2. Make any necessary changes to the configuration. For example:

   - Secrets and networking. These will be invalid since they depend on SSH keys, so you will want to remove it and the configuration in `system/common/modules/networking.nix`.
   - Hostnames and usernames.
   - Installed programs and their settings.

3. Make sure everything is saved. If you are intending to push to a git repo, make sure to `git add .` first. Then you can run `sudo nixos-rebuild switch .#<hostname>` or some variation to build.

You will be successful if everything you wanted installed, installs and is configured appropriately. The home-manager configuration will also be successfully built if you see `home-manager.<user>.service` was successfully (re)started. You can check its status with `systemctl status home-manager.<user>.service`.

## Themes, Icons and Colour Palette

These dotfiles uses the Nord theme.

1. The [Nord colour palette](https://nordtheme.com).
2. The GTK theme [Nordic](https://www.gnome-look.org/p/1267246/) by @EliverLara.
   Follow the instructions on the page to use the GTK3/4 theme.
3. I use the [Fira Code Retina Nerd](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode) and [Source Code Pro](https://github.com/adobe-fonts/source-code-pro) fonts. Both are TTFs.
4. I use the [Nordzy](https://github.com/alvatip/Nordzy-icon) icon theme.
5. I use [Nordzy-cursors](https://www.gnome-look.org/p/1571937) as my cursor theme.

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

This section is more information about the configuration, mainly for those who want to extend/use this configuration (though you're probably better off using @Misterio77's boilerplate).

### `flake.nix` structure

1. Description. Self-explanatory. Edit it to whatever `string` you want.
2. `inputs` attribute set contain the flake inputs. Where possible, I have tried to use flake inputs or overlays for as many (environment) programs as possible.
3. A bunch of `let` bindings. Namely:
   - `system`, `user`, `pkgs` for some easy reusable keywords
   - `colour-palette` which is the file containing the RGB hex codes for the Nord theme.
   - `mkSystemConfiguration` a function which creates a NixOS system with given hostname and users.
4. `outputs`. What the flake returns and allows you to access.
