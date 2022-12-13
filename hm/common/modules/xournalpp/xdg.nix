{
  config,
  builtins,
  ...
}: {
  xdg.configFile = {
    "xournalpp/settings.xml" = {
      source = config.lib.file.mkOutOfStoreSymlink ./. + "/config/settings.xml";
      target = "xournalpp/settings.xml";
    };
    "xournalpp/colornames.ini" = {
      source = config.lib.file.mkOutOfStoreSymlink ./. + "/config/colornames.ini";
      target = "xournalpp/colornames.ini";
    };
    "xournalpp/toolbar.ini" = {
      source = config.lib.file.mkOutOfStoreSymlink ./. + "/config/toolbar.ini";
      target = "xournalpp/toolbar.ini";
    };
  };
}
