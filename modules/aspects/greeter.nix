{ den, lib, ... }:
{
  den.aspects.greeter = {
    nixos =
      { pkgs, ... }:
      {
        services.greetd = {
          enable = true;
          useTextGreeter = true;
          settings = {
            default_session = {
              command = ''${lib.getExe pkgs.tuigreet} --time --cmd "start-hyprland" --greeting "With great power, comes great responsibility." '';
              user = "greeter";
            };
          };
        };
      };
  };
}
