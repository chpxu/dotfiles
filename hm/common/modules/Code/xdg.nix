{
  config,
  pkgs,
  ...
}: {
  xdg.configFile."Code/User/snippets/NT.code-snippets" = {
    source = config.lib.file.mkOutOfStoreSymlink ./. + "./config/NT.code-snippets";
    target = "Code/User/snippets/NT.code-snippets";
  };
  home.activation.beforeCheckLinkTargets = {
    after = [];
    before = ["checkLinkTargets"];
    data = ''
      userDir=${config.xdg.configHome}/Code/User
      rm -rf $userDir/settings.json
    '';
  };

  home.activation.afterWriteBoundary = {
    after = ["writeBoundary"];
    before = [];
    data = ''
      userDir=${config.xdg.configHome}/Code/User
      rm -rf $userDir/settings.json
      cat \
        ${(pkgs.formats.json {}).generate "blabla"
        config.programs.vscode.userSettings} \
        > $userDir/settings.json
    '';
  };
}
