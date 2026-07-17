{ inputs, ... }:
{
  den.aspects.overlays = {
    nixos = _: {
      nixpkgs.overlays = [
        inputs.cachy.overlays.pinned
        (_final: prev: {
          tuigreet = inputs.tuigreet.packages.${prev.hostPlatform.system}.tuigreet;
        })
        # Source: https://github.com/darkone-linux/darkone-nixos-framework/commit/85861f7fc026a82bda847d90e82ec5fc97b466b3
        (
          final: _prev:
          let
            # Use Logseq DB
            pname = "logseq";
            version = "2.0.1";

            src = final.fetchurl {
              url = "https://github.com/logseq/logseq/releases/download/nightly/Logseq-linux-x86_64-2.0.1.AppImage";
              hash = "sha256-c9BYlBsjspIgT4ICpsjYp2prVq42vFoLvEwAYill37c=";
            };

            # Extracted tree: source of the `.desktop` entry and the hicolor icons.
            contents = final.appimageTools.extractType2 { inherit pname version src; };

            inherit (final.lib) licenses sourceTypes;
          in
          {

            logseq = final.appimageTools.wrapType2 {
              inherit pname version src;

              # Upstream `.desktop` points to `Exec=Logseq` (inner binary); repoint it to
              # the `logseq` wrapper exposed by wrapType2, and copy the icons.
              extraInstallCommands = ''
                install -Dm444 ${contents}/logseq.desktop $out/share/applications/logseq.desktop
                 substituteInPlace $out/share/applications/${pname}.desktop \
                --replace-fail 'Exec=AppRun' 'Exec=logseq'
                cp -r ${contents}/usr/share/icons $out/share/
              '';

              meta = {
                description = "Privacy-first, open-source knowledge base (official AppImage)";
                homepage = "https://logseq.com";
                license = licenses.agpl3Only;
                sourceProvenance = [ sourceTypes.binaryNativeCode ];
                platforms = [ "x86_64-linux" ];
                mainProgram = "logseq";
              };
            };
          }

        )
      ];
    };
  };
}
