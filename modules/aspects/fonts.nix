_: {
  # Fonts
  den.aspects.fonts = {
    nixos =
      { pkgs, ... }:
      {
        fonts = {
          enableDefaultPackages = true;

          packages = with pkgs; [
            nerd-fonts.fira-code
            nerd-fonts.dejavu-sans-mono
            nerd-fonts.sauce-code-pro
            times-newer-roman
            dejavu_fonts
            newcomputermodern
            stix-two
          ];
          fontconfig = {
            hinting = {
              enable = true;
              style = "medium";
            };
            subpixel.rgba = "rgb";
            defaultFonts = {
              serif = [ "NewComputerModern" ];
              monospace = [ "FiraCode Nerd Font" ];
              sansSerif = [ "DejaVu Sans Mono" ];
            };
          };
        };
      };

  };
}
