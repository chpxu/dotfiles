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
            noto-fonts-cjk-serif
            noto-fonts-cjk-sans
            libertinus
          ];
          fontconfig = {
            hinting = {
              enable = true;
              style = "medium";
            };
            subpixel.rgba = "rgb";
            defaultFonts = {
              serif = [
                "NewComputerModern10"
                "Times Newer Roman"
                "Noto Serif CJK SC"
                "Noto Serif CJK TC"
              ];
              monospace = [
                "FiraCode Nerd Font"
                "SauceCodePro Nerd Font"
              ];
              sansSerif = [
                "DejaVu Sans"
                "Noto Sans CJK SC"
                "Noto Sans CJK TC"
              ];
            };
          };
        };
      };

  };
}
