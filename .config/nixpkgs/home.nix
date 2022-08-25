{ config, pkgs, lib, ... }:
let
  xournalpp-nord = import ./xournalpp/xournalpp-nordDark.nix;
	stable = import <nixos-stable> { config = { allowUnfree = true; }; };
in
{ 
  nixpkgs.config.allowUnfree = true;
  home.username = "chunix";
  home.homeDirectory = "/home/chunix";
    imports = [
    ./vscode.nix
    ./gh_git.nix
    ./waybar.nix
    ./zathura.nix
    ./mpv.nix
    ./kitty.nix
    ./mako.nix
    ./swaylock_swayidle.nix
    ./kanshi.nix
    ./xdg.nix
    #./texlive.nix
    ./firefox.nix
  ];
  # Install home packages
  home.packages = with pkgs; [
    # Reserve this for programs which do not have config options n home-manager
    # Audio
    pipewire
    wireplumber
    alsa-utils
		(pkgs.wayfire.overrideAttrs (oldAttrs: rec {
			version = "0.7.4";
			src = fetchurl {
				url = 
				"https://github.com/WayfireWM/wayfire/releases/download/v${version}/wayfire-${version}.tar.xz";
				sha256 = 
				"89e375f7320d7bd4023d9f9499f979ee7209594afbb5aa0cfd897934a7f0514d";
			};
    }))
    wcm
    wf-config
    bemenu
    cliphist
    grim
    slurp
    # swaylock-effects
    swayidle
    kanshi
    wl-clipboard
    #wlogout
    wofi
    imv
    # applications
    firefox-wayland
    thunderbird-wayland
    discord-canary
    betterdiscordctl
    inkscape-with-extensions
    gimp-with-plugins
    neofetch
    bitwarden
    # OneDrive
    onedrive
    # Virtual Keyboard
    wvkbd
   
    #unstable.wgcf
    unzip

    # Utils
    xdg-utils
    yt-dlp
    #ffmpeg_5-full
    jmtpfs
    #qespresso
    quantum-espresso

    ### Custom Packages or Derivations or Combinations etc
    # TeXLive
    texlive.combined.scheme-full
    #xournalpp-nord
    (pkgs.xournalpp.overrideAttrs (oldAttrs: rec {
			src = fetchFromGitHub {
        owner = "chpxu";
        repo = "xournalpp";
				rev = "8f44c87edf5367efc1f86f0ac8ab7234e98db214"; 
				sha256 = "wSP5BwluLDtScuK1/CuJUWbdTSJErNXUnlsECl7xbtU=";
			};
    }))
    neovim
  ];
  
  # GTK themes
  gtk = rec {
    enable = true;
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
    iconTheme = {
      name = "Nordzy";
      package = pkgs.nordzy-icon-theme;
    };
    cursorTheme = {
      name = "Nordzy-cursors";
      package = pkgs.nordzy-cursor-theme;
    };
    gtk2 = {
      configLocation = "${config.home.homeDirectory}/.gtkrc-2.0";
      extraConfig = ''
        gtk-cursor-theme-name = "${cursorTheme.name}"
        gtk-icon-theme-name = "${iconTheme.name}"
        gtk-theme-name = "${theme.name}"
      '';
    };
  };
  dconf = {
		settings = {
			"org/gnome/desktop/interface" = {
				gtk-theme = "Nordic";
				cursor-theme = "Nordzy-cursors";
			};
			"org/gnome/desktop/wm/preferences" = {
				theme = "Nordic";
			};
		};
  };
  programs.zsh = {
    dotDir = ".config/zsh";
    history = {
      path = "${config.xdg.configHome}/zsh/zsh_history";
    };
    shellAliases = {
      od = "onedrive --synchronize --upload-only && onedrive --synchronize --no-remote-delete";
    };
    enableSyntaxHighlighting = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    loginExtra = ''
      wayfire
      betterdiscordctl --d-modules ~/.config/discordcanary/0.0.136/modules/install
    '';
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [
        "git" "gh" "fzf" "npm" "thefuck" "zsh-interactive-cd"
      ];
    };
  }; 
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;
}
