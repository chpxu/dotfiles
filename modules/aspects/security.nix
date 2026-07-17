{
  den.aspects.security = {
    nixos = _: {
      # RTKit
      security.rtkit.enable = true;
      security.polkit.enable = true;
      security.polkit.enablePkexecWrapper = true;
      # PAM and swaylock
      security.pam.services.swaylock = {
        text = "auth include login";
      };

    };
  };
}
