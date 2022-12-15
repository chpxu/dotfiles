{
  # RTKit
  security.rtkit.enable = true;
  security.polkit.enable = true;
  # PAM and swaylock
  security.pam.services.swaylock = {
    text = "auth include login";
  };
}
