{
  config,
  pkgs,
  hostname ? "",
  ...
}: {
  networking = {
    # Define hostname
    hostName = hostname;
    # Pick only one of the below networking options.
    # Enables wireless support via wpa_supplicant.
    # wireless.enable = true;
    wireless.scanOnLowSignal = false;
    wireless.environmentFile = "/run/p.env";
    # Easiest to use and most distros use this by default.
    # networking.networkmanager.enable = true;
    # FIXME: Manage wireless secrets
    wireless.networks = {};
  };
}
