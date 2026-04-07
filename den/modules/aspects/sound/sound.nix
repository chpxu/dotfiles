{
  den.aspects.sound = {
    nixos = {
      environment.etc = {
        "pipewire.conf" = {
          enable = true;
          source = ./pipewire.conf;
          mode = "0644";
          target = "pipewire.conf.d/pipewire.conf";
        };
        "pipewire-pulse.conf" = {
          enable = true;
          source = ./pipewire-pulse.conf;
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
        wireplumber.extraConfig."10-bluez" = {
          "monitor.bluez.properties" = {
            "bluez5.enable-sbc-xq" = true;
            "bluez5.enable-msbc" = true;
            "bluez5.enable-hw-volume" = true;
            "bluez5.roles" = [
              "hsp_hs"
              "hsp_ag"
              "hfp_hf"
              "hfp_ag"
            ];
          };
        };

      };
    };
  };
}
