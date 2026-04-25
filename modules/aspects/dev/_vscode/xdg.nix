{
  config,
  pkgs,
  ...
}:
{
  xdg.configFile."Code/User/snippets/NT.code-snippets" = {
    source = config.lib.file.mkOutOfStoreSymlink ./. + "./config/NT.code-snippets";
    target = "Code/User/snippets/NT.code-snippets";
  };
  home.activation.beforeCheckLinkTargets = {
    after = [ ];
    before = [ "checkLinkTargets" ];
    data = ''
      userDir=${config.xdg.configHome}/Code/User
      rm -rf $userDir/settings.json
    '';
  };

  home.activation.afterWriteBoundary =
    let
      userSettings = (import ./settings.nix).settings;
    in
    {
      after = [ "writeBoundary" ];
      before = [ ];
      data = ''
        userDir=${config.xdg.configHome}/Code/User
        rm -rf $userDir/settings.json
        cat ${pkgs.writeText "tmp_vscode_settings" (builtins.toJSON userSettings)} | jq --monochrome-output > $userDir/settings.json

      '';
    };
}
