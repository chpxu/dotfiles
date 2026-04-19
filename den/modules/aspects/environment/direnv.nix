_: {
  den.aspects.direnv = {
    homeManager =
      { config, ... }:
      {
        programs.direnv = {
          enable = true;
          enableBashIntegration = true;
          enableZshIntegration = true;
          nix-direnv.enable = true;
          config = {
            whitelist = {
              prefix = [
                "${config.home.homeDirectory}/projects"
                "${config.home.homeDirectory}/Projects"
                "${config.home.homeDirectory}/git_projects"
              ];
            };
          };
        };
      };
  };
}
