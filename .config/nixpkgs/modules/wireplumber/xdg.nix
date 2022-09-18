{config, ...}: {
  xdg.configFile = {
    "wireplumber/bluetooth.lua.d/50-bluez-config.lua" = {
      source = config.lib.file.mkOutOfStoreSymlink ./. + "/config/bluetooth.lua.d/50-bluez-config.lua";
      target = "wireplumber/bluetooth.lua.d/50-bluez-config.lua";
    };
    # "wireplumber/main.lua.d/30-alsa-monitor.lua" = {
    #   source = config.lib.file.mkOutOfStoreSymlink ./. + "/config/main.lua.d/30-alsa-config.lua";
    #   target = "wireplumber/main.lua.d/30-alsa-config.lua";
    # };
  };
}
