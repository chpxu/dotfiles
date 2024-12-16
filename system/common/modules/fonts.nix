{pkgs, ...}: {
  # Fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      # caudex
      nerd-fonts.fira-code
      nerd-fonts.dejavu-sans-mono
      nerd-fonts.sauce-code-pro
      times-newer-roman
      dejavu_fonts
      newcomputermodern
    ];
    fontconfig = {
      hinting = {
        enable = true;
        style = "medium";
      };
      subpixel.rgba = "rgb";
      defaultFonts = {
        serif = ["Times Newer Roman"];
        monospace = ["FiraCode Nerd Font"];
        sansSerif = ["DejaVu Sans Mono"];
      };
    };
  };
}
