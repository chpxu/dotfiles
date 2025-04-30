{hostname, ...}: {
  services.openssh.enable = true;
  services.nscd.enableNsncd = true;
  networking = {
    hostName = hostname;
    firewall.enable = true;
    networkmanager.enable = true;
  };
}
