{
  config,
  pkgs,
  ...
}:
let
  configDirName = "VSCodium";
in
{
  xdg.configFile."Code/User/snippets/NT.code-snippets" = {
    source = config.lib.file.mkOutOfStoreSymlink ./. + "./config/NT.code-snippets";
    target = "VSCodium/User/snippets/NT.code-snippets";
    force = true;
  };
  # home.activation.makeVSCodeConfigWritable =
  #   let
  #     configPath = "${config.xdg.configHome}/${configDirName}/User/settings.json";
  #   in
  #   {
  #     after = [ "writeBoundary" ];
  #     before = [ ];
  #     data = ''
  #       install -m 0640 "$(readlink ${configPath})" ${configPath}
  #     '';
  #   };
  # home.activation.beforeCheckLinkTargets = {
  #   after = [ ];
  #   before = [ "checkLinkTargets" ];
  #   data = ''
  #     userDir=${config.xdg.configHome}/Code/User
  #     rm -rf $userDir/settings.json
  #   '';
  # };

  home.activation.afterWriteBoundary =
    let
      userSettings = (import ./settings.nix).settings;
    in
    {
      after = [ "writeBoundary" ];
      before = [ ];
      data = ''
        userDir=${config.xdg.configHome}/${configDirName}/User
        rm -rf $userDir/settings.json
        cat ${pkgs.writeText "tmp_vscode_settings" (builtins.toJSON userSettings)} | jq --monochrome-output > $userDir/settings.json

      '';
    };
}
