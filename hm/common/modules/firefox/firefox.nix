{
  config,
  pkgs,
  ...
}: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition-bin;
    profiles = {
      dev-edition-default = {
        path = "q7h52to1.dev-edition-default";
        isDefault = true;
        settings = (import ./config/settings.nix).settings;
        extensions = with config.nur.repos.rycee.firefox-addons; [
          # Main issue is configuring extensions declaratively
          # 1. The .xpi file must be extracted
          # 2. The file for  per extension must be located
          # 3. The function `buildFirefoxXpiAddon` only downloads the xpi file directly, which itself is just a glorified .zip file. This means if we override the url to point to our own build, we can have a (sort-of) declarative way. IT's convenient the function is mkOverridable
          bitwarden
          tabcenter-reborn
          ublock-origin
          auto-tab-discard
          # zotero
        ];
      };
      dev-edition-uni = {
        id = 1;
        name = "University";
        path = "uni";
        settings = (import ./config/settings.nix).settings;
        userChrome = '''';
        extensions = with config.nur.repos.rycee.firefox-addons; [
          # Main issue is configuring extensions declaratively
          # 1. The .xpi file must be extracted
          # 2. The file for  per extension must be located
          # 3. The function `buildFirefoxXpiAddon` only downloads the xpi file directly, which itself is just a glorified .zip file. This means if we override the url to point to our own build, we can have a (sort-of) declarative way. IT's convenient the function is mkOverridable
          bitwarden
          tabcenter-reborn
          ublock-origin
          auto-tab-discard
        ];
      };
      # dummy = {
      #   id = 9999;
      #   isDefault = false;
      #   extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      #     ublock-origin
      #     auto-tab-discard
      #   ];
      # };
    };
  };
}
