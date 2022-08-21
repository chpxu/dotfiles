{
  packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball {
        url = "https://github.com/nix-community/NUR/archive/1f80e16537599cff4c125eb306b0af827818e97c.tar.gz";
        sha256 = "1l28ds47xzn5aw8k6hg7j8arfq8pv22vpg6vy830ddwxa42jwwfv";
    }) {
      inherit pkgs;
    };
  };
}