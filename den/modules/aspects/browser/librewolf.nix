{
  den.aspects.browsers.provides.librewolf = {
    homeManager = {
      programs.librewolf.enable = true;
      programs.librewolf.profiles = {
        main = {
          bookmarks.settings = [
            {
              name = "Nix sites";
              toolbar = true;
              bookmarks = [
                {
                  name = "homepage";
                  url = "https://nixos.org/";
                }
                {
                  name = "wiki";
                  tags = [
                    "wiki"
                    "nix"
                  ];
                  url = "https://wiki.nixos.org/";
                }
                {
                  name = "hma";
                  tags = [
                    "wiki"
                    "nix"
                    "hm"
                    "home"
                  ];
                  url = "https://nix-community.github.io/home-manager/options.xhtml/";
                }
              ];
            }
          ];
        };
      };
    };
  };
}
