{config, ...}: {
  xdg.configFile."Code/User/snippets/NT.code-snippets" = {
    source = config.lib.file.mkOutOfStoreSymlink ./. + "./config/NT.code-snippets";
    target = "/Code/User/snippets/NT.code-snippets";
  };
}
