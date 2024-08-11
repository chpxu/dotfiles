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
      if [ -if "$userDir"];
        rm -rf $userDir/settings.json
      fi
    '';
  };

  home.activation.afterWriteBoundary = {
    after = ["writeBoundary"];
    before = [];
    data = ''
      userDir=${config.xdg.configHome}/Code/User
      if [ -if "$userDir"];
        rm -rf $userDir/settings.json
      fi
      cat \
        ${(pkgs.formats.json {}).generate "blabla"
        config.programs.vscode.userSettings} \
        > $userDir/settings.json
    '';
  };
}
