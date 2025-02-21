{
  config,
  hostname,
  ...
}: {
  services.openssh.enable = true;
  services.nscd.enableNsncd = true;
  # imports = [<sops-nix/modules/sops>];
  # This will add secrets.yml to the nix store
  # You can avoid this by adding a string to the full path instead, i.e.
  # sops.defaultSopsFile = "/root/.sops/secrets/example.yaml";
  sops.defaultSopsFile = ../../../secrets/secrets.yaml;
  # This will automatically import SSH keys as age keys
  sops.age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
  # This is using an age key that is expected to already be in the filesystem
  # sops.age.keyFile = "/var/lib/sops-nix/key.txt";
  sops.age.keyFile = /home/chunix/.config/sops/age/keys.txt;
  # This will generate a new key if the key specified above does not exist
  sops.age.generateKey = true;
  sops.secrets."wireless.env" = {
    mode = "0440";
  };
  systemd.services."wpa_supplicant" = {
    serviceConfig.SupplementaryGroups = [config.users.groups.keys.name];
  };
  networking = {
    hostName = hostname;
    firewall.enable = true;
    wireless.enable = true;
    wireless.scanOnLowSignal = false;
    wireless.secretsFile = config.sops.secrets."wireless.env".path;
    wireless.networks = {
      "ext:home_uuid" = {
        hidden = true;
        psk = "ext:home_psk";
        authProtocols = ["WPA-PSK"];
      };
      #Uni
      "ext:uni_uuid" = {
        psk = "ext:uni_psk";
        authProtocols = ["WPA-PSK"];
      };
      "ext:campus_uuid" = {
        extraConfig = ''
          identity="ext:campus_identity"
          password=ext:campus_psk
          key_mgmt=WPA-EAP
          eap=PEAP
          phase1="peaplabel=0"
          phase2="auth=MSCHAPV2"
          ca_cert="/etc/ssl/certs/ca-bundle.crt"
          priority=1
        '';
      };
    };
  };
}
