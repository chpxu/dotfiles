{lib, ...}: {
  den.aspects.greeter = {
    provides.to-users = _: {
      homeManager = {
        xdg.configFile = {
          "tuigreet/config.toml" = {
            target = "tuigreet/config.toml";
            force = true;
            source = ./environment/tuigreet/config.toml;
            recursive = true;
          };
        };
      };
    };

    nixos =
      { pkgs, ... }:
      {
        environment.etc = {
          "tuigreet/config.toml" = {
            target = "tuigreet/config.toml";
            source = ./environment/tuigreet/config.toml;
          };
        };
        services.greetd = {
          enable = true;
          useTextGreeter = true;
          settings = {
            default_session = {
              command = ''${
                lib.getExe pkgs.tuigreet
              } --cmd "start-hyprland" --config /etc/tuigreet/config.toml --time --greeting "With great power, comes great responsibility" --background doom'';
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
