{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.firefox = {
    enable = true;
    package =
      pkgs.firefox-wayland;
    # pkgs.wrapFirefox pkgs.firefox-devedition-bin-unwrapped {
    #   forceWayland = true;
    #   extraPolicies = {
    #     ExtensionSettings = {};
    #   };
    # };
    extensions = with config.nur.repos.rycee.firefox-addons; [
      bitwarden
      tabcenter-reborn
      ublock-origin
    ];
    profiles = {
      chunix = {
        id = 0;
        name = "chunix";
        isDefault = true;
        path = "g0yz2hb9.default";
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
