_: {
  den.aspects.art = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          inkscape-with-extensions
          gimp3
        ];
      };
  };
}
