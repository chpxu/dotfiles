{ inputs, ... }: {
  den.aspects.browsers.provides.firefox = {

    homeManager =
      {
        pkgs,
        config,
        lib,
        ...
      }:
      let
        searchConfig = {
          search.default = "Startpage";
          search.engines = {
            "Startpage" = {
              urls = [
                {
                  template = "https://www.startpage.com/sp/search?q={searchTerms}";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = [ "@sp" ];
            };
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages?channel=unstable";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };

            "NixOS Wiki" = {
              urls = [ { template = "https://wiki.nixos.org/index.php?search={searchTerms}"; } ];
              iconUpdateURL = "https://wiki.nixos.org/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@nw" ];
            };
            "Google Scholar" = {
              definedAliases = [ "@gs" ];
              urls = [
                {
                  template = "https://scholar.google.com/scholar?hl=en&q={searchTerms}";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            };
            "Bing".metaData.hidden = true;
            "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
          };
        };
      in
      {
        #imports = [ inputs.textfox.homeManagerModules.default ];
        home.activation.unclobberSearchMZML = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          userDir=${config.xdg.configHome}/mozilla/firefox

          rm -rf $userDir/**/search.json.mozlz4
        '';
        programs.firefox = {
          enable = true;
          package = pkgs.firefox-devedition;
          configPath = "${config.xdg.configHome}/mozilla/firefox";
          profiles = {
            dev-edition-default = {
              inherit (searchConfig) search;
              name = "dev-edition-default";
              path = "dev-edition-default";
              isDefault = true;
              id = 0;
              inherit ((import ./_settings.nix)) settings;
              # extensions = with config.nur.repos.rycee.firefox-addons; [
              #   # Main issue is configuring extensions declaratively
              #   # 1. The .xpi file must be extracted
              #   # 2. The file for  per extension must be located
              #   # 3. The function `buildFirefoxXpiAddon` only downloads the xpi file directly, which itself is just a glorified .zip file. This means if we override the url to point to our own build, we can have a (sort-of) declarative way. IT's convenient the function is mkOverridable
              #   bitwarden
              #   tabcenter-reborn
              #   ublock-origin
              #   auto-tab-discard
              #   # zotero
              # ];

            };
            dev-edition-uni = {
              id = 1;
              name = "University";
              path = "uni";
              inherit ((import ./_settings.nix)) settings;
              inherit (searchConfig) search;
            };
          };
        };
        #textfox = {
         # enable = false;
          # Replace with the names of profiles, defined in home-manager, or find existing ones in `about:profiles`
          #profiles = [
           # "dev-edition-default"
            #"uni"
          #];
          #config = {
            # Optional config
          #};
        #};
      };
  };
}
