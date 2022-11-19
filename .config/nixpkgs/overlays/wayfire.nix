{
  nixpkgs.overlays = final: prev: {
    wayfire = prev.wayfire.overrideAttrs (oldAttrs: rec {
      version = "0.7.4";
      src = fetchFromGitHub {
        owner = "WayfireWM";
        repo = "wayfire";
        rev = "a55a12291fe8d10a59c7ae35c4c958261998c465";
        sha256 = "sha256-UkM/DPJixG75i3FJ88HCAglxajmcpYjxffhST8lsyZk=";
      };
    });
  };
}
