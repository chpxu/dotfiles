{pkgs, ...}: let
  hyprland = pkgs.callPackage ./hyprland/default.nix {inherit pkgs;};
in {
  home.packages = with pkgs; [
    pipewire
    wireplumber
    alsa-utils
    (pkgs.wayfire.overrideAttrs (oldAttrs: rec {
      version = "0.7.4";
      # src = fetchurl {
      #   url = "https://github.com/WayfireWM/wayfire/releases/download/v${version}/wayfire-${version}.tar.xz";
      #   sha256 = "89e375f7320d7bd4023d9f9499f979ee7209594afbb5aa0cfd897934a7f0514d";
      # };
      src = fetchFromGitHub {
        owner = "WayfireWM";
        repo = "wayfire";
        rev = "a55a12291fe8d10a59c7ae35c4c958261998c465";
        sha256 = "sha256-UkM/DPJixG75i3FJ88HCAglxajmcpYjxffhST8lsyZk=";
      };
    }))
    wcm
    wf-config
    # hyprland
    bemenu
    cliphist
    grim
    slurp
    swayidle
    kanshi
    wl-clipboard
    wofi
    imv
    #(pkgs.hyprland.overrideAttrs (oldAttrs: rec {

    #}))
  ];
  #++ [hyprland];
}
