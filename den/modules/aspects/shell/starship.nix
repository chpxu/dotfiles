{
  den.aspects.starship = {
    nixos = {
      programs.starship = {
        enable = true;
        settings = builtins.fromTOML (builtins.readFile ./starship.toml);
      };
    };
    homeManager =
      { config, ... }:
      {
        programs.starship = {
          enable = true;
          enableBashIntegration = true;
          enableZshIntegration = true;
        };
      };
  };
}
