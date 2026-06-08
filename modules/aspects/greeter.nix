{ lib, ... }:
{
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
        services.greetd = {
          enable = true;
          useTextGreeter = true;
          settings = {
            default_session = {
              command = ''${lib.getExe pkgs.tuigreet} --time --cmd "start-hyprland" --config "$HOME/.config/tuigreet/config.toml'';
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
