{
  config,
  builtins,
  ...
}: let
  # xournalVars = import ./xournalpp.nix;
  # paths = import /. + "${config.home.homeDirectory}/git_projects/dotfiles/.config/nixpkgs/common/paths.nix";
in {
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
