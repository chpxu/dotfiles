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
    useTextGreeter = true;
    settings = {
      default_session = {
        command = ''${pkgs.tuigreet}/bin/tuigreet --time --cmd Hyprland --greeting "With great power, comes great responsibility." '';
        user = "greeter";
      };
    };
  };
}
