# This file pmakes a marksman package into my nix store to allow for it to be used inside my neovim setup
{
  stdenv,
  builtins,
  ...
}:
stdenv.mkDerivation rec {
  name = "marksman-linux";
  pname = "marksman";
  version = "2022-08-28";
  src = builtins.fetchurl {
    url = "https://github.com/artempyanykh/marksman/releases/download/${version}/${name}";
    sha256 = "hTsfViDwTE87Eskihis6364bUTQrajPUnqWFbrC8c2E=";
  };
  platform = "x86_64-linux";
  dontUnpack = true;
  dontConfigure = true;
  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp "$src" "$out/bin/"
    runHook postInstall
  '';
  postInstallPhase = ''
    mv "$out/bin/${name}" "$out/bin/${pname}"
    chmod u+x marksman
  '';
  # installPhase = ''
  #   runHook preInstall
  #   path = $out/bin/${name}
  #   mkdir -p "$path"
  #   cp $out "$path"
  #   runHook postInstall
  # '';
}
