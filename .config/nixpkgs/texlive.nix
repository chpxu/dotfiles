with import <nixpkgs> { config = { allowUnfree = true; }; };
with builtins;
with lib;
let
  # define unpackPhase here.
  unpackSources = ''
    runHook preUnpack
    for _src in $srcs; do
      cp "$_src" $(stripHash "$_src")
    done
    runHook postUnpack
  '';
  #This is a function to build any source provided ins and dtx files are given.
  makeLatexPkg = { 
    name, version ? "", sources ? null, hasIns ? true
  } @args: {
    latexPkg = stdenv.mkDerivation rec {
      inherit name;
      inherit version;
      pname = name;
      passthru.tlType = "run";
      nativeBuildInputs = [ texlive.combined.scheme-small coreutils ];
      dontConfigure = true;
      srcs = map (source: (fetchurl { url = source; })) sources;
      unpackPhase = unpackSources;
      buildPhase = ''
        runHook preBuild
        if [ -f "./${name}.ins" ]; then
          latex ${name}.ins 
        else
          echo "no ins file found but hasIns was set to true!"
        fi
        runHook postBuild
      '';
      installPhase = ''
        runHook preInstall
        if [ "$hasIns" = true ]; then
          path="$out/tex/latex"
          mkdir -p "$path"
          cp ./* "$path/"
        elif [ "$hasIns" != true ]; then
          path="$out/tex/latex/${name}"
          mkdir -p "$path"
          cp ./* "$path/"
        else
          echo "There was no ins/dtx or sty/other files provided." 
        fi
        runHook postInstall
      '';
    };
  };
  # Start making the package derivations here
  esint = makeLatexPkg {
    name = "esint"; 
    version = "1.2d"; 
    sources = [
      "http://mirrors.ctan.org/macros/latex/contrib/esint/esint.dtx"
      "http://mirrors.ctan.org/macros/latex/contrib/esint/esint.ins"
    ];
    hasIns = true;
  };
  logreq = makeLatexPkg {
    name = "logreq"; 
    sources = [
      "http://mirrors.ctan.org/macros/latex/contrib/logreq/logreq.sty"
      "http://mirrors.ctan.org/macros/latex/contrib/logreq/logreq.def"
    ];
    hasIns = false;
  };
  biblatex = makeLatexPkg {
    name = "biblatex"; 
    version = "v3.18b"; 
    sources = [
      "http://mirrors.ctan.org/macros/latex/contrib/biblatex/latex/blx-case-expl3.sty"
      "http://mirrors.ctan.org/macros/latex/contrib/biblatex/latex/blx-case-latex2e.sty"
      "http://mirrors.ctan.org/macros/latex/contrib/biblatex/latex/blx-bibtex.def"
      "http://mirrors.ctan.org/macros/latex/contrib/biblatex/latex/blx-unicode.def"
      "http://mirrors.ctan.org/macros/latex/contrib/biblatex/latex/blx-natbib.def"
      "http://mirrors.ctan.org/macros/latex/contrib/biblatex/latex/blx-compat.def"
      "http://mirrors.ctan.org/macros/latex/contrib/biblatex/latex/blx-dm.def"
      "http://mirrors.ctan.org/macros/latex/contrib/biblatex/latex/blx-mcite.def"
      "http://mirrors.ctan.org/macros/latex/contrib/biblatex/latex/biblatex.cfg"
      "http://mirrors.ctan.org/macros/latex/contrib/biblatex/latex/biblatex.sty"
      "http://mirrors.ctan.org/macros/latex/contrib/biblatex/latex/biblatex.def"
    ];
    hasIns = false;
  };
  importpkg = makeLatexPkg {
    name = "import"; 
    sources = [
      "http://mirrors.ctan.org/macros/latex/contrib/import/import.sty"
    ];
    hasIns = false;
  };
  subfiles = makeLatexPkg {
    name = "subfiles"; 
    sources = [
      "http://mirrors.ctan.org/macros/latex/contrib/subfiles/subfiles.dtx"
      "http://mirrors.ctan.org/macros/latex/contrib/subfiles/subfiles.ins"
    ];
    hasIns = true;
  };
  tcolorbox = makeLatexPkg {
    name = "tcolorbox"; 
    sources = [
      "http://mirrors.ctan.org/macros/latex/contrib/tcolorbox/tcolorbox.sty"
    ];
    hasIns = true;
  };
  customTexlive = texlive.combine {
    inherit (texlive) scheme-tetex;
    latexPkgs = { 
      pkgs = [ 
        esint.latexPkg 
        logreq.latexPkg 
        biblatex.latexPkg 
        subfiles.latexPkg
        importpkg.latexPkg
        tcolorbox.latexPkg
      ]; 
    };
  };
in 
{
  home.packages = [
      customTexlive
  ];
}
