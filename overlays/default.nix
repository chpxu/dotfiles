{
  clisp = final: prev: {
    clisp = prev.clisp.override {
      # On newer readline8 fails as:
      #  #<FOREIGN-VARIABLE "rl_readline_state" #x...>
      #   does not have the required size or alignmen
      readline = prev.readline63;
    };
  };
  # waybar = self: super: {
  #   # waybar overlay to build with experimental
  #   waybar = super.waybar.overrideAttrs (oldAttrs: {
  #     mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
  #   });
  # };
  # discord-canary = self: super: {
  #   discord-canary = super.discord-canary.overrideAttrs (oldAttrs: rec {
  #     # version = "0.0.140";
  #     version = "0.0.148";
  #     src = super.fetchurl {
  #       url = "https://dl-canary.discordapp.net/apps/linux/${version}/discord-canary-${version}.tar.gz";
  #       # sha256 = "sha256-AEbjkAMeOJ48RVgbVj35Rp26klCsCsDCX+VD5u1xCM0="; #ver 0.0.140
  #       #sha256 = "sha256-TF+7SnCTsbh+Z8AeEESEFVLSpD3c5HOAwpU1UBuB1BU=";
  #       #0.0.145
  #       sha256 = "sha256-2ZrSDyPj3AHriCWZ/bb303H3J97TTun//WjmInNEmwk=";
  #     };
  #   });
  # };
  # bitwarden = self: super: {
  #   bitwarden = super.bitwarden.overrideAttrs (oldAttrs: rec {
  #     # bitwardenver = "2022.12.0";
  #     version = "2022.12.0";
  #     src = super.fetchurl {
  #       url = "https://github.com/bitwarden/clients/releases/download/desktop-v${version}/Bitwarden-${version}-amd64.deb";
  #       sha256 = "sha256-deQG1GEYmnQmO5+jASsiQmDphb+4Jyq9aSn/A4z++uE=";
  #     };
  #   });
  # };
  wvkbd = self: super: {
    wvkbd = super.wvkbd.overrideAttrs (oldAttrs: {
      src = super.fetchFromGitHub {
        owner = "chpxu";
        repo = "wvkbd";
        rev = "312c03b94c1165924e0b20f7188aa11d41e363b3";
        sha256 = "";
      };
    });
  };
  # xournalpp = self: super: {
  #   xournalpp = super.xournalpp.overrideAttrs (oldAttrs: {
  #     src = super.fetchFromGitHub {
  #       owner = "chpxu";
  #       repo = "xournalpp1";
  #       rev = "a855de6fd90c26615787b47a8fcb29084003a4d3";
  #       sha256 = "sha256-ltfyJGTAa14ze7+dTzvGmNQ+nqG/7a3kaMDWjrjTeUs=";
  #     };
  #   });
  # };
  # wayfire = self: super: {
  #   wayfire = super.wayfire.overrideAttrs (oldAttrs: {
  #     version = "0.7.4";
  #     src = super.fetchFromGitHub {
  #       owner = "WayfireWM";
  #       repo = "wayfire";
  #       rev = "a55a12291fe8d10a59c7ae35c4c958261998c465";
  #       sha256 = "sha256-UkM/DPJixG75i3FJ88HCAglxajmcpYjxffhST8lsyZk=";
  #     };
  #   });
  # };
}
