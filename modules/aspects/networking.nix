{ lib, ... }:
{
  den.aspects.networking = {
    nixos =
      {
        pkgs,
        ...
      }:
      {
        systemd.network.wait-online.enable = false;
        boot.initrd.systemd.network.wait-online.enable = false;
        services.openssh.enable = true;
        services.nscd.enableNsncd = true;
        networking = {
          wireless.enable = true;
          firewall.enable = true;
          networkmanager = {
            enable = true;
            plugins = with pkgs; [
              networkmanager-openconnect
              networkmanager-openvpn
            ];
            dhcp = "dhcpcd";
          };
          useDHCP = lib.mkDefault true;
          dhcpcd.enable = true;
          # name
        };

        #services.mullvad-vpn.enable = true;
      };
  };
}
