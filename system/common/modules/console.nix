{ pkgs, ... }:
{
  console = {
    enable = true;
    earlySetup = false;
    packages = with pkgs; [ terminus_font ];
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    keyMap = "uk";
    colors = [
      "2e3440"
      "bf616a"
      "a3be8c"
      "d08770"
      "81a1c1"
      "b48ead"
      "88c0d0"
      "8fbcbb"
      "3b4252"
      "bf616a"
      "5e81ac"
      "8fbcbb"
      "8fbcbb"
      "434c5e"
      "d8dee9"
      "ebcb8b"
    ]; # blue red green orange light-blue pink cyan? light-pink(turquoise)? polar-night2 deepred teal lessteal purple grey
  };
}
