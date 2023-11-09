{pkgs, ...}: {
  # RTKit
  security.rtkit.enable = true;
  security.polkit.enable = true;
  # PAM and swaylock
  security.pam.services.swaylock = {
    text = "auth include login";
  };
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "greeter";
      };
    };
    vt = 2;
  };
}
