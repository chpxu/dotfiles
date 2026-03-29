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
    swaylock-effects
    starship
    openconnect
    gpclient
    pavucontrol
    btop-cuda
  ];
in {
  environment.systemPackages =
    if needsNvidia
    then systemPackages ++ [nvidia-offload]
    else systemPackages;
  hardware.acpilight.enable = true;
  programs = {
    dconf.enable = true;

    steam = {
      enable = true;
      gamescopeSession = {enable = true;};
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };

    gamescope.enable = true;
    #Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
