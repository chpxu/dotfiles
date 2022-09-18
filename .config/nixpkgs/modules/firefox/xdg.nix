{
  config,
  lib,
  options,
  specialArgs,
  modulesPath,
}: {
  home.file = {
    ".config/firefox/chrome/oneline.css" = {
      source = config.lib.file.mkOutOfStoreSymlink ./. + "./config/oneline.css";
      target = ".mozilla/firefox/g0yz2hb9.default/chrome/oneline.css";
    };
    ".config/firefox/chrome/verticaltabs.css.css" = {
      source = config.lib.file.mkOutOfStoreSymlink ./. + "./config/verticaltabs.css";
      target = ".mozilla/firefox/g0yz2hb9.default/chrome/verticaltabs.css";
    };
  };
}
