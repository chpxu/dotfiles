{pkgs, ...}: {
  console = {
    earlySetup = true;
    packages = with pkgs; [terminus_font];
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    keyMap = "us";
    #keyMap = "us";
    #useXkbConfig = true; # use xkbOptions in tty.
  };
}
