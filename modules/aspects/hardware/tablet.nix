{
  den.aspects.hardware.provides.tablet = {
    nixos = {
      hardware.uinput.enable = true;
      hardware.opentabletdriver = {
        enable = true;
        daemon.enable = true;
      };
    };
  };
}
