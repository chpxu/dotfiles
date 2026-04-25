_: {
  den.aspects.disks = {
    nixos = {
      services.udisks2 = {
        enable = true;
        mountOnMedia = true;
      };
    };
  };
}
