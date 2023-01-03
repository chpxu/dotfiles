{
  config,
  lib,
  ...
}: {
  # home.file = {
  #   ".config/firefox/chrome/oneline.css" = {
  #     source = config.lib.file.mkOutOfStoreSymlink ./. + "/config/oneline.css";
  #     target = "${config.home.homeDirectory}/.mozilla/firefox/g0yz2hb9.default/chrome/oneline.css";
  #   };
  #   ".config/firefox/chrome/verticaltabs.css" = {
  #     source = config.lib.file.mkOutOfStoreSymlink ./. + "/config/verticaltabs.css";
  #     target = "${config.home.homeDirectory}/.mozilla/firefox/g0yz2hb9.default/chrome/verticaltabs.css";
  #   };
  #   ".config/firefox/chrome/nord-peaks.png" = {
  #     source = config.lib.file.mkOutOfStoreSymlink ./. + "/config/nord-peaks.png";
  #     target = ".mozilla/firefox/g0yz2hb9.default/chrome/nord-peaks.png";
  #   };
  #   Organise stylesheets for firefox chrome
  #   ".config/firefox/chrome/components/menupopup/menupopup.css" = {
  #     source = config.lib.file.mkOutOfStoreSymlink ./. + "/config/components/menupopup/menupopup.css";
  #     target = ".mozilla/firefox/g0yz2hb9.default/chrome/components/menupopup/menupopup.css";
  #   };
  #   ".config/firefox/chrome/components/menupopup/contents.css" = {
  #     source = config.lib.file.mkOutOfStoreSymlink ./. + "/config/components/menupopup/contents.css";
  #     target = ".mozilla/firefox/g0yz2hb9.default/chrome/components/menupopup/contents.css";
  #   };
  #   ".mozilla/firefox/chunix/chrome" = {
  #     source = config.lib.file.mkOutOfStoreSymlink ./. + "/chrome";
  #     recursive = true;
  #     # target = ".mozilla/firefox/chunix/chrome";
  #   };
  # };
  xdg.configFile = {
    "firefox/chrome" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/chunix/dotfiles/hm/common/modules/firefox/chrome";
      recursive = true;
    };
  };
  home.activation = {
    symlinkChrome = lib.hm.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD ln -s -f $VERBOSE_ARG \
          "${config.xdg.configHome}/firefox/chrome" "$HOME/.mozilla/firefox/q7h52to1.dev-edition-default"
    '';
  };
}
