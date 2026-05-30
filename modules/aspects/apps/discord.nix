_: {
  den.aspects.discord = {
    homeManager = _: {

      programs.vesktop = {
        enable = true;
        settings = {
          hardwareAcceleration = true;
          discordBranch = "canary";
          checkUpdates = false;
        };
        vencord = {
          extraQuickCss = builtins.readFile ./system24nord.css;
          settings = {
            enabledThemes = [ "system24nord.css" ];
            autoUpdate = false;
            autoUpdateNotification = false;
            disableMinSize = true;
            notifyAboutUpdates = false;
            plugins = {
              FakeNitro = {
                enabled = true;
              };
              MessageLogger = {
                enabled = true;
                ignoreSelf = true;
              };
            };
            useQuickCss = true;
          };

        };
      };
    };
  };
}
