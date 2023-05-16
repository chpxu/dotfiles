{...}: {
  xdg = {
    enable = true;
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
    desktopEntries = {
      zathura = {
        type = "Application";
        name = "Zathura";
        comment = "A minimalistic document viewer";
        exec = "zathura %U";
        icon = "org.pwmt.zathura";
        terminal = false;
        categories = ["Office" "Viewer"];
        # Keywords = ["PDF" "PS" "PostScript" "DjVU" "document" "presentation" "viewer"];
        mimeType = ["application/pdf"];
      };
    };
    mime.enable = true;
    mimeApps = {
      enable = true;
      # TO-DO: Mime associations where necessary
      defaultApplications = {
        "application/pdf" = ["org.pwmt.zathura.desktop"];
      };
    };
  };
}
