{pkgs, ...}: {
  home.packages = with pkgs; [
    pipewire
    wireplumber
    alsa-utils
    # (pkgs.wayfire.overrideAttrs (oldAttrs: rec {
    #   version = "0.7.4";
    #   # src = fetchurl {
    #   #   url = "https://github.com/WayfireWM/wayfire/releases/download/v${version}/wayfire-${version}.tar.xz";
    #   #   sha256 = "89e375f7320d7bd4023d9f9499f979ee7209594afbb5aa0cfd897934a7f0514d";
    #   # };
    #   src = fetchFromGitHub {
    #     owner = "WayfireWM";
    #     repo = "wayfire";
    #     rev = "a55a12291fe8d10a59c7ae35c4c958261998c465";
    #     sha256 = "sha256-UkM/DPJixG75i3FJ88HCAglxajmcpYjxffhST8lsyZk=";
    #   };
    # }))
    (pkgs.hyprpaper.overrideAttrs (oldAttrs: rec {
      src = fetchFromGitHub {
        owner = "hyprwm";
        repo = "hyprpaper";
        rev = "6d3a15f33cedaa8f01b0f96c8d2a1f8de24bbb33";
        hash = "sha256-+k/21qDW+RKBKFKkjRmntWemJR8/5bZyyoDTKr/emCU=";
      };
    }))
    # wcm
    # wf-config
    # hyprland
    bemenu
    cliphist
    grim
    slurp
    swayidle
    # kanshi
    wl-clipboard
    wofi
    imv
    krusader
    xdg-utils
    unzip
    jmtpfs
    xorg.xprop
    wev
  ];
}
