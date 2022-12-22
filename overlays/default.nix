rec {
  discordver = "0.0.140";
  clisp =  (final: prev: {
      clisp = prev.clisp.override {
        # On newer readline8 fails as:
        #  #<FOREIGN-VARIABLE "rl_readline_state" #x...>
        #   does not have the required size or alignment
        readline = prev.readline6;
      };
    });
  waybar = self: super: {
    # waybar overlay to build with experimental
    waybar = super.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
    });
  };
  # Hyprpaper overlay since the nix flake does not work (issue with formatter/alejandra?)
  hyprpaper = self: super: {
    hyprpaper = super.hyprpaper.overrideAttrs (oldAttrs: rec {
      src = super.fetchFromGitHub {
        owner = "hyprwm";
        repo = "hyprpaper";
        rev = "88d99f99546d3ba42ed40f9b371471b320423f63";
        sha256 = "sha256-ssWr9KskwbfTA3s93AeV24khVYLyWUFL2XRDyn6XB14=";
      };
    });
  };
  discord-canary = self: super: {
    discord-canary = super.discord-canary.overrideAttrs (oldAttrs: rec {
      version = discordver;
      src = super.fetchurl {
        url = "https://dl-canary.discordapp.net/apps/linux/${version}/discord-canary-${version}.tar.gz";
        sha256 = "sha256-AEbjkAMeOJ48RVgbVj35Rp26klCsCsDCX+VD5u1xCM0=";
      };
    });
  };
  wvkbd = self: super: {
    wvkbd = super.wvkbd.overrideAttrs (oldAttrs: rec {
      src = super.fetchFromGitHub {
        owner = "chpxu";
        repo = "wvkbd";
        rev = "6ee1764535a06b9888242ad4a9c42a7ac9821791";
        sha256 = "TWd/CECWxZJ0WeFVjeuHWAq9fGKGOd6MLpjvzOpKGOo=";
      };
    });
  };
  xournalpp = self: super: {
    xournalpp = super.xournalpp.overrideAttrs (oldAttrs: rec {
      src = super.fetchFromGitHub {
        owner = "chpxu";
        repo = "xournalpp1";
        rev = "0f9ff2d756cb59746b6a863fca25f5ee5318b0ce";
        sha256 = "sha256-w9kR7Qy6wRf7U6PmyUVpEuD5U1Lp+04FXHO/aCmDPrU=";
      };
    });
  };
  wayfire = self: super: {
    wayfire = super.wayfire.overrideAttrs (oldAttrs: rec {
      version = "0.7.4";
      src = super.fetchFromGitHub {
        owner = "WayfireWM";
        repo = "wayfire";
        rev = "a55a12291fe8d10a59c7ae35c4c958261998c465";
        sha256 = "sha256-UkM/DPJixG75i3FJ88HCAglxajmcpYjxffhST8lsyZk=";
      };
    });
  };
}
