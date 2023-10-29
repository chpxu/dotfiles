{config, ...}: {
  xdg.configFile."waybar/wvkbd.sh" = {
    source = config.lib.file.mkOutOfStoreSymlink ./. + "/config/wvkbd.sh";
    target = "waybar/wvkbd.sh";
  };
  xdg.configFile."waybar/white-snowflake.png" = {
    source = config.lib.file.mkOutOfStoreSymlink ./. + "/config/white-snowflake.png";
    target = "waybar/white-snowflake.png";
  };
}
