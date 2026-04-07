# # enables `nix run .#vm`. it is very useful to have a VM
# # you can edit your config and launch the VM to test stuff
# # instead of having to reboot each time.
{
  inputs,
  den,
  lib,
  ...
}:

{
  # USER TODO: remove this tty-autologin used for the VM
  # den.aspects.jingliu.includes = [ (den.provides.tty-autologin "chunix") ];
  # den.aspects.saitama.includes = [ (den.provides.tty-autologin "chunix") ];

  perSystem =
    { pkgs, ... }:
    let
      mkVM =
        hostname:
        pkgs.writeShellApplication {
          name = "vm-${hostname}";
          text =
            let
              host = inputs.self.nixosConfigurations.${hostname}.config;
            in
            ''
              ${host.system.build.vm}/bin/run-${host.networking.hostName}-vm "$@"
            '';
        };
    in
    {
      packages = lib.listToAttrs (
        map (hostname: {
          name = "vm-${hostname}";
          value = mkVM hostname;
        }) (builtins.attrNames inputs.self.nixosConfigurations)
      );
    };
}
