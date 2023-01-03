{
  config,
  pkgs,
  colour-palette,
  ...
}: {
  programs.zathura = {
    enable = true;
    package = pkgs.zathura;
    options = {
      window-title-basename = "true";
      selection-clipboard = "clipboard";
      notification-error-bg = "${colour-palette.nord11}";
      notification-error-fg = "${colour-palette.nord4}";
      notification-warning-bg = "${colour-palette.nord12}";
      notification-warning-fg = "${colour-palette.nord6}";
      notification-bg = "${colour-palette.nord0}";
      notification-fg = "${colour-palette.nord4}";
      completion-bg = "${colour-palette.nord0}";
      completion-fg = "${colour-palette.nord1}";
      completion-group-bg = "${colour-palette.nord0}";
      completion-group-fg = "${colour-palette.nord1}";
      completion-highlight-bg = "${colour-palette.nord3}";
      completion-highlight-fg = "${colour-palette.nord4}";
      index-bg = "${colour-palette.nord0}";
      index-fg = "${colour-palette.nord4}";
      index-active-bg = "${colour-palette.nord3}";
      index-active-fg = "${colour-palette.nord4}";
      inputbar-bg = "${colour-palette.nord0}";
      inputbar-fg = "${colour-palette.nord4}";
      statusbar-bg = "${colour-palette.nord0}";
      statusbar-fg = "${colour-palette.nord4}";
      highlight-color = "${colour-palette.nord12}";
      highlight-active-color = "${colour-palette.nord15}";
      default-bg = "${colour-palette.nord0}";
      default-fg = "${colour-palette.nord4}";
      render-loading = true;
      render-loading-fg = "${colour-palette.nord0}";
      render-loading-bg = "${colour-palette.nord4}";
      recolor-lightcolor = "${colour-palette.nord0}";
      recolor-darkcolor = "${colour-palette.nord4}";
      adjust-open = "width";
      # recolor = true;
    };
  };
}
