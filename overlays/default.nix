{
  wvkbd = self: super: {
    wvkbd = super.wvkbd.overrideAttrs (oldAttrs: {
      src = super.fetchFromGitHub {
        owner = "chpxu";
        repo = "wvkbd";
        rev = "312c03b94c1165924e0b20f7188aa11d41e363b3";
        sha256 = "sha256-oMLzeg996ilFxGeaceeyKMysCkTxxqUA73mjUy2pCGs=";
      };
    });
  };
  zotero_7 = self: super: {
    zotero_7 = super.zotero_7.overrideAttrs (oldAttrs: rec {
      version = "7.0.0-beta";
      src = super.fetchurl {
        url = "https://download.zotero.org/client/beta/${version}.83%2B066eda731/Zotero-${version}.83%2B066eda731_linux-x86_64.tar.bz2";
        hash = "sha256-wqew12/Icv4XS+IJRVcf1Rh/ipqBhe8QGkP8ErfS4J0=";
      };
    });
  };
}
