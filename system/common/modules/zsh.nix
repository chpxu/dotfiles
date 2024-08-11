{
  programs.zsh = {
    enable = true;
  };
  programs.starship = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ./starship/startship.toml);
  };
}
