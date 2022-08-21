{}:
{
stdenv.mkDerivation  {
  name = "xournalpp";
  src = ./.;
  buildInputs = [ 
    cmake
    glib
    pkg-config
    gtk3
    gettext
    wrapGAppsHook
    #lib
    #stdenv
    # fetchFromGitHub
    # gsettings-desktop-schemas
    librsvg
    libsndfile
    libxml2
    libzip
    pcre
    poppler
    portaudio
    zlib
  ];
  platform = "x86_64-linux";
  # configurePhase = "mkdir build && cd build";
  # buildPhase = "cmake ../../src";
  # installPhase = "cmake --build . --target install";
  # postInstall = "./cmake/postinst configure"; 
}
}