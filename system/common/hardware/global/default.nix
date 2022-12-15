{pkgs, ...}: {
  hardware.video.hidpi.enable = true;
  hardware.uinput.enable = true;
  hardware.opentabletdriver = {
    enable = true;
    package = pkgs.opentabletdriver;
    daemon.enable = true;
  };
}
