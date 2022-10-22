{
  config,
  pkgs,
  lib,
  ...
}: {
  nixpkgs.overlays = let
    # Change this to a rev sha to pin
    moz-rev = "80627b282705101e7b38e19ca6e8df105031b072";
    moz-url = builtins.fetchTarball {
      url = "https://github.com/mozilla/nixpkgs-mozilla/archive/${moz-rev}.tar.gz";
      sha256 = "11g9lppm53f5aq7a0fnwh5hivdhn2p1wmhwgmz1052x10hfqjrah";
    };
    nightlyOverlay = import "${moz-url}/firefox-overlay.nix";
  in [
    nightlyOverlay
  ];
  programs.firefox = {
    enable = true;
    package = pkgs.latest.firefox-nightly-bin;
    extensions = with config.nur.repos.rycee.firefox-addons; [
      # Main issue is configuring extensions declaratively
      # 1. The .xpi file must be extracted
      # 2. The file for options per extension must be located
      # 3. The function `buildFirefoxXpiAddon` only downloads the xpi file directly, which itself is just a glorified .zip file. This means if we override the url to point to our own build, we can have a (sort-of) declarative way. IT's convenient the function is mkOverridable
      bitwarden
      tabcenter-reborn
      ublock-origin
    ];
    profiles = {
      chunix = {
        id = 0;
        name = "chunix";
        isDefault = true;
        path = "chunix";
        settings = (import ./config/settings.nix).settings;
        userChrome = (import ./config/userChrome.nix).userChrome;
        userContent = (import ./config/userContent.nix).userContent;
      };
      dummy = {
        id = 1;
        isDefault = false;
      };
    };
  };
}
