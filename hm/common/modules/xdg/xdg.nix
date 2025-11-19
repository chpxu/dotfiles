{
  config,
  inputs,
  pkgs,
  ...
}: let
  editorRequired = ["code.desktop"];
  pdf = ["org.pwmt.zathura.desktop"];
  image = ["imv.desktop" "org.inkscape.Inkscape.desktop" "gimp.desktop"];
  audioVideo = ["mpv.desktop"];
  word = "write.desktop";
  excel = "calc.desktop";
  ppt = "impress.desktop";
  office = ["startcenter.desktop" word excel ppt "math.desktop" "draw.desktop" "base.desktop"];
  files = ["yazi.desktop"];
in {
  xdg = {
    enable = true;
    systemDirs = {
      config = ["/etc/xdg"];
      data = ["/usr/share" "/usr/local/share"];
    };
    userDirs = {
      enable = true;
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
        XDG_MISC_DIR = "${config.home.homeDirectory}/Misc";
        XDG_SCREENSHOTS_DIR = "${config.home.homeDirectory}/Screenshots";
        XDG_WALLPAPER_DIR = "${config.home.homeDirectory}/Pictures/Wallpapers";
      };
    };
    mime.enable = true;
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
        };
      };
    };
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config = {
        common.default = ["gtk"];
        hyprland.default = [
          "hyprland"
          "gtk"
        ];
      };
      extraPortals = [
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
      ];
    };
  };
}
