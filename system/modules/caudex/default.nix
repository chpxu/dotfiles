{
  lib,
  fetchFromGitHub,
}: let
  pname = "caudex";
  version = "1.0.0";
in
  fetchFromGitHub {
    name = "${pname}-${version}";
    owner = "chpxu";
    repo = "caudex";
    rev = version;
    sha256 = "0lvkqg1g4ygkjaf2vy9qbah5rvz7l30i5d0whbfhg64lzyyakhiq";
    postFetch = ''
      tar -xf $downloadedFile --strip=1
      install -m444 -Dt $out/share/fonts/*.ttf
    '';
    stripRoot = false;
  }
