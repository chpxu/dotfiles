{ inputs, ... }:
{
  den.aspects.chunix-xdg = {
    nixos =
      { pkgs, ... }:
      {
        xdg = {
          icons.enable = true;
          portal = {
            enable = true;
            wlr.enable = true;
            xdgOpenUsePortal = true;
            extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
          };
        };
      };
    homeManager =
      {
        config,
        pkgs,
        ...
      }:
      let
        editorRequired = [ "code.desktop" ];
        pdf = [ "org.pwmt.zathura.desktop" ];
        image = [
          "imv.desktop"
          "org.inkscape.Inkscape.desktop"
          "gimp.desktop"
        ];
        audioVideo = [ "mpv.desktop" ];
        word = "write.desktop";
        excel = "calc.desktop";
        ppt = "impress.desktop";
        office = [
          "startcenter.desktop"
          word
          excel
          ppt
          "math.desktop"
          "draw.desktop"
          "base.desktop"
        ];
        files = [ "yazi.desktop" ];
        browser = [ "firefox-devedition.desktop" ];
      in
      {
        xdg = {
          enable = true;
          terminal-exec = {
            enable = true;
            settings = {
              default = [
                "kitty.desktop"
              ];
            };
          };
          systemDirs = {
            config = [ "/etc/xdg" ];
            data = [
              "/usr/share"
              "/usr/local/share"
            ];
          };
          userDirs = {
            enable = true;
            setSessionVariables = true;
            createDirectories = true;
            desktop = "${config.home.homeDirectory}/Desktop";
            documents = "${config.home.homeDirectory}/Documents";
            download = "${config.home.homeDirectory}/Downloads";
            music = "${config.home.homeDirectory}/Music";
            pictures = "${config.home.homeDirectory}/Pictures";
            videos = "${config.home.homeDirectory}/Videos";
            templates = null;
            publicShare = null;
            extraConfig = {
              MISC = "${config.home.homeDirectory}/Misc";
              SCREENSHOTS = "${config.home.homeDirectory}/Screenshots";
              WALLPAPER = "${config.home.homeDirectory}/Pictures/Wallpapers";
            };
          };
          mime.enable = true;
          configFile."mimeapps.list".force = true;
          mimeApps = {
            enable = true;
            # TO-DO: Mime associations where necessary
            defaultApplications = {
              "application/pdf" = pdf;
              "application/epub+zip" = pdf;
              "application/gzip" = files;
              "application/xml" = editorRequired;
              "application/msword" = word;
              "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = word;
              "text/plain" = editorRequired;
              "text/html" = editorRequired;
              "text/css" = editorRequired;
              "image/*" = image;
              "audio/*" = audioVideo;
              "video/*" = audioVideo;
            };
            associations = {
              added = {
                "application/msword" = office;
                "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = office;
                "application/x-extension-shtml" = browser;
                "application/x-extension-xhtml" = browser;
                "application/x-extension-html" = browser;
                "application/x-extension-xht" = browser;
                "application/x-extension-htm" = browser;
                "x-scheme-handler/unknown" = browser;
                "x-scheme-handler/mailto" = browser;
                "x-scheme-handler/chrome" = browser;
                "x-scheme-handler/about" = browser;
                "x-scheme-handler/https" = browser;
                "x-scheme-handler/http" = browser;
                "application/xhtml+xml" = browser;
                "application/json" = browser;
                "text/plain" = browser;
                "text/html" = browser;
              };
            };
          };
          portal = {
            enable = true;
            xdgOpenUsePortal = true;
            config = {
              common.default = [ "gtk" ];
              hyprland.default = [
                "hyprland"
                "gtk"
              ];
            };
            extraPortals = [
              inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
              pkgs.xdg-desktop-portal-gtk
            ];
          };
        };
      };

  };
}
