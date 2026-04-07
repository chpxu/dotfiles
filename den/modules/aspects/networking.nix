{ den, ... }:
{
  den.aspects.networking = {
    nixos =
      {
        pkgs,
        ...
      }:
      {
        services.openssh.enable = true;
        services.nscd.enableNsncd = true;
        networking = {
          firewall.enable = true;
          networkmanager = {
            enable = true;
            plugins = with pkgs; [
              networkmanager-openconnect
              networkmanager-openvpn
            ];
          };
        };
        services.mullvad-vpn.enable = true;
      };
  };
}
