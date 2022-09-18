{
  config,
  pkgs,
  lib,
  ...
}: let
  gitProjConfig = "git_projects/dotfiles/.config";
in {
  xdg = {
    enable = true;
    # cacheHome = ~/.cache;
    # dataHome = ~/.local/share;
    # stateHome = ~/.local/state;
    systemDirs = {
      config = ["/etc/xdg"];
      data = ["/usr/share" "/usr/local/share"];
    };
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "$HOME";
      documents = "$HOME/Documents";
      download = "$HOME/Downloads";
      music = "$HOME/Music";
      pictures = "$HOME/Pictures";
      videos = "$HOME/Videos";
      templates = "$HOME";
      publicShare = "$HOME";
      extraConfig = {
        XDG_MISC_DIR = "$HOME/Misc";
      };
    };
    mime.enable = true;
    mimeApps = {
      enable = true;
      # TO-DO: Mime associations where necessary
    };
    # xdg.configFile for a program is managed in a programs' ./modules/<program>/xdg.nix
    # configFile = {
    #   BetterDiscord = {
    #     source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/${gitProjConfig}/BetterDiscord/themes";
    #     recursive = true;
    #   };
    #   #   light = {
    #   #     source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/${gitProjConfig}/light";
    #   #     recursive = true;
    #   #   };
    #   neofetch = {
    #     source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/${gitProjConfig}/neofetch";
    #     recursive = true;
    #   };
    #   swaylock = {
    #     source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/${gitProjConfig}/swaylock";
    #     recursive = true;
    #   };
    #   vscodeSnippets = {
    #     source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/${gitProjConfig}/Code/User/snippets/NT.code-snippets";
    #   };
    #   wayfireIni = {
    #     source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/${gitProjConfig}/wayfire.ini";
    #   };
    #   wfShell = {
    #     source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/${gitProjConfig}/wf-shell.ini";
    #   };
    #   wofi = {
    #     source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/${gitProjConfig}/wofi";
    #     recursive = true;
    #   };
    #   xournalppcss = {
    #     source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/${gitProjConfig}/xournalpp/xournalpp.css";
    #   };
    #   xournalpptoolbar = {
    #     source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/${gitProjConfig}/xournalpp/toolbar.ini";
    #   };
    #   xournalppSettings = {
    #     source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/${gitProjConfig}/xournalpp/settings.xml";
    #   };
    #   xournalppColours = {
    #     source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/${gitProjConfig}/xournalpp/colornames.ini";
    #   };
    # };
  };
}
