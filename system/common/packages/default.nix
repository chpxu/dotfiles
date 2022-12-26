{
  pkgs,
  needsNvidia ? false,
  ...
}: let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
  systemPackages = with pkgs; [
    nano
    curl
    cacert
    tlp
    dconf
    linux-pam
    pciutils
    age
    alsa-utils
    home-manager
    (pkgs.swaylock-effects.overrideAttrs (oldAttrs: {
      src = fetchFromGitHub {
        owner = "jirutka";
        repo = "swaylock-effects";
        rev = "b2736c5bef3add118183654305d05903c5947668";
        sha256 = "sha256-umxEwegKuJd/DUjaUQ88lbcQNxSY99yepBnQaFr3fDI=";
      };
    }))
  ];
in {
  # List packages installed in system profile.
  # Trying to keep as lean as possible.
  environment.systemPackages =
    if needsNvidia
    then systemPackages ++ [nvidia-offload pkgs.egl-wayland]
    else systemPackages;

  programs = {
    light.enable = true;
    dconf.enable = true;

    #Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
