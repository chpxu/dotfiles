{
  config,
  pkgs,
  ...
}: let
  nord = import ../../common/nordtheme.nix;
in {
  programs.zathura = {
    enable = true;
    package = pkgs.zathura;
    options = {
      window-title-basename = "true";
      selection-clipboard = "clipboard";
      notification-error-bg = "${nord.nord11}";
      notification-error-fg = "${nord.nord4}";
      notification-warning-bg = "${nord.nord12}";
      notification-warning-fg = "${nord.nord6}";
      notification-bg = "${nord.nord0}";
      notification-fg = "${nord.nord4}";
      completion-bg = "${nord.nord0}";
      completion-fg = "${nord.nord1}";
      completion-group-bg = "${nord.nord0}";
      completion-group-fg = "${nord.nord1}";
      completion-highlight-bg = "${nord.nord3}";
      completion-highlight-fg = "${nord.nord4}";
      index-bg = "${nord.nord0}";
      index-fg = "${nord.nord4}";
      index-active-bg = "${nord.nord3}";
      index-active-fg = "${nord.nord4}";
      inputbar-bg = "${nord.nord0}";
      inputbar-fg = "${nord.nord4}";
      statusbar-bg = "${nord.nord0}";
      statusbar-fg = "${nord.nord4}";
      highlight-color = "${nord.nord12}";
      highlight-active-color = "${nord.nord15}";
      default-bg = "${nord.nord0}";
      default-fg = "${nord.nord4}";
      render-loading = true;
      render-loading-fg = "${nord.nord0}";
      render-loading-bg = "${nord.nord4}";
      recolor-lightcolor = "${nord.nord0}";
      recolor-darkcolor = "${nord.nord4}";
      adjust-open = "width";
      # recolor = true;
    };
  };
}
