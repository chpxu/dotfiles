_: {
  den.aspects.greeter = {
    homeManager = {
      xdg.configFile = {
        "tuigreet/config.toml" = {
          target = "tuigreet/config.toml";
          force = true;
          text = builtins.readFile ./environment/tuigreet/config.toml;
        };
      };
    };
    nixos =
      { pkgs, ... }:
      {
        environment.etc = {
          tuigreetconfig = {
            target = "tuigreet/config.toml";
            text = builtins.readFile ./environment/tuigreet/config.toml;
          };
        };
        environment.systemPackages = [ pkgs.tuigreet ];
        services.greetd = {
          enable = true;
          useTextGreeter = true;
          settings = {
            default_session = {
              command = ''${pkgs.tuigreet}/bin/tuigreet --cmd "start-hyprland" --config /etc/tuigreet/config.toml'';
              user = "greeter";
            };
            terminal = {
              vt = 1;
            };
          };
        };
      };
  };
}
