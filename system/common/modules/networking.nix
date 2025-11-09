{
  hostname,
  pkgs,
  ...
}: {
  services.openssh.enable = true;
  services.nscd.enableNsncd = true;
  networking = {
    hostName = hostname;
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
}
