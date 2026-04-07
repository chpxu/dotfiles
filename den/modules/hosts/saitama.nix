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
      den.aspects.hardware._.nvidia
      den.aspects.graphics
      # den.aspects.greeter
      den.aspects.sound
      den.aspects.starship
    ];
    nixos =
      { pkgs, ... }:
      {
        networking.hostName = "saitama";
        environment.systemPackages = [ pkgs.hello ];

      };

    # # host provides default home environment for its users
    # provides.to-users.homeManager = {pkgs, ...}: {
    #   home.packages = [
    #     pkgs.vim
    #   ];
    # };
  };

  # be sure to add nix-darwin input for this:
  # den.hosts.aarch64-darwin.apple.users.alice = { };

  # other hosts can also have user tux.
  # den.hosts.x86_64-linux.south = {
  #   wsl = { }; # add nixos-wsl input for this.
  #   users.tux = { };
  #   users.orca = { };
  # };
}
