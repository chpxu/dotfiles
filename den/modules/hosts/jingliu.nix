# defines all hosts + users + homes.
# then config their aspects in as many files you want
{
  den,
  inputs,
  ...
}:
{
  den.hosts.x86_64-linux.jingliu.users.chunix = {
  };

  den.aspects.jingliu = {
    # host NixOS configuration
    includes = [
      den.aspects.boot
      den.aspects.hardware._.nvidia
      den.aspects.hardware._.nvidia-offload
      den.aspects.graphics
      den.aspects.starship
    ];
    nixos =
      { pkgs, ... }:
      {
        imports = [ inputs.nixos-hardware.nixosModules.lenovo-legion-16iah7h ];
        environment.systemPackages = [ pkgs.hello ];
        networking.hostName = "jingliu";
      };
    gpu = "nvidia";
    offload = true;

    # host provides default home environment for its users
    # provides.to-users.homeManager = {pkgs, ...}: {
    #   home.packages = [
    #     pkgs.vim
    #     pkgs.btop-cuda
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
