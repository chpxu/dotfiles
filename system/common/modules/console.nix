{pkgs, ...}: {
  console = {
    earlySetup = false;
    packages = with pkgs; [terminus_font];
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    keyMap = "us";
    #keyMap = "us";
    #useXkbConfig = true; # use xkbOptions in tty.
  };
  services.xserver.enable = true;
  services.xserver.displayManager.defaultSession = "hyprland";
  services.xserver.autorun = false;
  services.xserver.displayManager.startx.enable = true;
  services.xserver.displayManager.sddm.enable = true;
}
