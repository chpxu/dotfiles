{pkgs, ...}: {
  # Fonts
  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      # caudex
      (
        nerdfonts.override {
          fonts = ["FiraCode" "DejaVuSansMono" "SourceCodePro"];
        }
      )
      pkgs.times-newer-roman
    ];
    fontconfig = {
      hinting = {
        enable = true;
        style = "medium";
      };
      defaultFonts = {
        serif = ["Times Newer Roman"];
        monospace = ["FiraCode Nerd Font"];
        sansSerif = ["DejaVu Sans Mono"];
      };
    };
  };
}
