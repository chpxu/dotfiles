{
  pkgs,
  lib,
  stdenv,
  fetchFromGitHub,
  fetchFromGitLab,
  cmake,
  libdrm,
  libinput,
  libxcb,
  libxkbcommon,
  mesa,
  pango,
  cairo,
  pkg-config,
  wayland,
  wayland-protocols,
  wayland-scanner,
  wlroots,
  xcbutilwm,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "hyprland";
  version = "0.17.0beta";

  src = fetchFromGitHub {
    owner = "hyprwm";
    repo = "Hyprland";
    rev = "v${finalAttrs.version}";
    hash = "sha256-0b1kVcyDOrkluCSIkKmz3FO/cN4/Amz1uIU3EyvojPA=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
    wayland-scanner
  ];

  buildInputs =
    [
      libdrm
      libinput
      libxcb
      libxkbcommon
      mesa
      pango
      cairo
      wayland
      wayland-protocols
      xcbutilwm
    ]
    ++ [
      # INFO: When updating src, remember to synchronize this wlroots with the
      # exact commit used by upstream
      (wlroots.overrideAttrs (_: {
        version = "unstable-2022-11-05";
        src = fetchFromGitLab {
          domain = "gitlab.freedesktop.org";
          owner = "wlroots";
          repo = "wlroots";
          rev = "92e3c5b7980890895ee6b882723c9b434c53b0c6";
          hash = "sha256-W/kAPpns4bRDoUMXDdCf13p33MDghWz66VOi59EWRZc=";
        };
      }))
    ];

  # build with system wlroots
  postPatch = ''
    sed -Ei 's|"\.\./wlroots/include/([a-zA-Z0-9./_-]+)"|<\1>|g' src/includes.hpp
  '';

  preConfigure = ''
    make protocols
  '';

  postBuild = ''
    pushd ../hyprctl
    ${stdenv.cc.targetPrefix}c++ -std=c++20 -w ./main.cpp -o ./hyprctl
    popd
  '';

  installPhase = ''
    runHook preInstall
    install -Dm755 ../hyprctl/hyprctl ./Hyprland -t $out/bin
    runHook postInstall
  '';

  meta = with lib; {
    inherit (finalAttrs.src.meta) homepage;
    description = "A dynamic tiling Wayland compositor that doesn't sacrifice on its looks";
    license = licenses.bsd3;
    maintainers = with maintainers; [wozeparrot];
    inherit (wayland.meta) platforms;
    mainProgram = "Hyprland";
    # ofborg failure: g++ does not recognize '-std=c++23'
    broken = stdenv.isAarch64;
  };
})
