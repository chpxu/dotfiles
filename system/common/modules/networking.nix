{
  #   config,
  #   pkgs,
  builtins,
  lib,
  hostname ? "",
  ...
}: {
  # FIXME: Manage wireless secrets
  # networking = lib.mkMerge [
  #   {
  #     hostName = hostname;
  #     wireless.enable = true;
  #     wireless.scanOnLowSignal = false;
  #     # wireless.environmentFile = "/run/p.env";
  #     # Easiest to use and most distros use this by default.
  #     # networking.networkmanager.enable = true;
  #   }
  #   (lib.mkIf (builtins.pathExists ../secrets.nix) {
  #     wireless.networks = (import ../secrets.nix).networks;
  #   })
  # ];
  networking = {
    hostName = hostname;
    # wireless.enable = true;
    wireless.scanOnLowSignal = false;
    # wireless.networks = import ../secrets.nix;
  };
}
