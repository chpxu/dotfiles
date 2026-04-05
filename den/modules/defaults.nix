{ lib, den, ... }:
{
  den.default.nixos.system.stateVersion = "25.11";
  den.default.homeManager.home.stateVersion = "25.11";

  # enable hm by default
  den.schema.user.classes = lib.mkDefault [ "homeManager" ];

  # host<->user provides
  den.ctx.user.includes = [ den._.mutual-provider ];
  # includes = [
  #   den.provides.define-user
  #   den.provides.hostname
  #   den.provides.inputs'
  #   den.provides.self'
  # ];

  # User TODO: REMOVE THIS
  # den.aspects.tux.nixos = {
  #   boot.loader.grub.enable = false;
  #   fileSystems."/".device = "/dev/fake";
  # };
}
