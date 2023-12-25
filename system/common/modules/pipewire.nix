{
  environment.etc = {
    "pipewire.conf" = {
      enable = true;
      source = ./pipewire/pipewire.conf;
      mode = "0644";
      target = "pipewire.conf.d/pipewire.conf";
    };
    "pipewire-pulse.conf" = {
      enable = true;
      source = ./pipewire/pipewire-pulse.conf;
      mode = "0644";
      target = "pipewire.conf.d/pipewire-pulse.conf";
    };
  };
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
}
