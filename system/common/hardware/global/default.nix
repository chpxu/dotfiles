{
  hardware.uinput.enable = true;
  # hardware.opentabletdriver = {
  #   enable = true;
  #   package = pkgs.opentabletdriver;
  #   daemon.enable = true;
  # };
  # Enable PulseAudio sound.
  # sound.enable = true;
  hardware.pulseaudio.enable = false;
}
