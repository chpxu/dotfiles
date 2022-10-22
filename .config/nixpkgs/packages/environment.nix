{pkgs, ...}: {
  home.packages = with pkgs; [
    pipewire
    wireplumber
    alsa-utils
    (pkgs.wayfire.overrideAttrs (oldAttrs: rec {
      version = "0.7.4";
      src = fetchurl {
        url = "https://github.com/WayfireWM/wayfire/releases/download/v${version}/wayfire-${version}.tar.xz";
        sha256 = "89e375f7320d7bd4023d9f9499f979ee7209594afbb5aa0cfd897934a7f0514d";
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
  ];
}
