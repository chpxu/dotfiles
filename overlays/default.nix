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
  #logseq = final: prev: {
   #   logseq = prev.logseq.override {
   #       electron = prev.electron_27;
   #   };
   #};
}
