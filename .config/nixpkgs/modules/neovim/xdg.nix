{config, ...}: {
  xdg.configFile = {
    "nvim/init.lua" = {
      source = config.lib.file.mkOutOfStoreSymlink ./. + "/config/init.lua";
      target = "nvim/init.lua";
    };
    "nvim/lua" = {
      source = config.lib.file.mkOutOfStoreSymlink ./. + "/config/lua";
      recursive = true;
    };
  };
}
