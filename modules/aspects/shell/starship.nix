{
  den.aspects.starship = {
    nixos = {
      programs.starship = {
        enable = true;
        settings = fromTOML (builtins.readFile ./starship.toml);
      };
    };
    homeManager = _: {
      programs.starship = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
      };
    };
  };
}
