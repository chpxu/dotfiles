# defines all hosts + users + homes.
# then config their aspects in as many files you want
{
  den,
  inputs,
  ...
}:
{
  den.hosts.x86_64-linux.saitama.users.chunix = {

  };

  # define an standalone home-manager for tux
  # den.homes.x86_64-linux.chunix = { };

  den.aspects.saitama = {
    gpu = "nvidia";
    offload = false;

    # host NixOS configuration
    includes = [
      den.aspects.boot
      den.aspects.console
      den.aspects.fonts
      den.aspects.networking
      den.aspects.security
      den.aspects.graphics
      den.aspects.hardware._.nvidia
      den.aspects.greeter
      den.aspects.sound
    ];
    # nixos =
    #   { pkgs, ... }:
    #   {
    #     environment.systemPackages = [ pkgs.hello ];

    #   };

    # # # host provides default home environment for its users
    # provides.to-users.homeManager =
    #   { pkgs, ... }:
    #   {
    #     # home.packages = [
    #     #   # pkgs.fresh-editor
    #     # ];
    #   };
  };

}
