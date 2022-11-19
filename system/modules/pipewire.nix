{ config, pkgs, ...}:
{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
   	alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    config.pipewire = {
      "context.properties" = {
        "link.max-buffers" = 16;
        "log.level" = 2;
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 32;
        "default.clock.min-quantum" = 2;
        "default.clock.max-quantum" = 128;
        "core.daemon" = true;
        "core-name" = "pipewire-0";
      };
      "context.modules" = [
        {
          name = "libpipewire-module-rtkit";
          args = {
            "nice.level" = -15;
            "rt.prio" = 88;
            "rt.time.soft" = -1;
            "rt.time.hard" = -1;
          };
          flags = [ "ifexists" "nofail" ];
        }
        { name = "libpipewire-module-protocol-native"; }
        { name = "libpipewire-module-profiler"; }
        { name = "libpipewire-module-metadata"; }
        { name = "libpipewire-module-spa-device-factory"; }
        { name = "libpipewire-module-spa-node-factory"; }
        { name = "libpipewire-module-client-node"; }
        { name = "libpipewire-module-client-device"; }
        {
          name = "libpipewire-module-portal";
          flags = [ "ifexists" "nofail" ];
        }
        {
          name = "libpipewire-module-access";
          args = {};
        }
        { name = "libpipewire-module-adapter"; }
        { name = "libpipewire-module-link-factory"; }
        { name = "libpipewire-module-session-manager"; }
      ];
    };
    config.pipewire-pulse = {
      "context.properties" = {
        "log.level" = 2;
      };
      "context.modules" = [
        {
          name = "libpipewire-module-rtkit";
          args = {
            "nice.level" = -15;
            "rt.prio" = 88;
            "rt.time.soft" = -1;
            "rt.time.hard" = -1;
          };
          flags = [ "ifexists" "nofail" ];
        }
        { name = "libpipewire-module-protocol-native"; }
        { name = "libpipewire-module-client-node"; }
        { name = "libpipewire-module-adapter"; }
        { name = "libpipewire-module-metadata"; }
        {
          name = "libpipewire-module-protocol-pulse";
          args = {
	    			"pulse.min.req" = "32/48000";
	    			"pulse.default.req" = "32/48000";
	    			"pulse.max.req" = "32/48000";
	    			"pulse.min.quantum" = "32/48000";
	    			"pulse.max.quantum" = "32/48000";
      	    "server.address" = [ "unix:native" ];
	  			};
        }
      ];
      "stream.properties" = {
        "node.latency" = "32/48000";
        "resample.quality" = 4;
      };
      "pulse.properties" = {
        "server.address" = [ "unix:native" ];
      };
    };

  };
}