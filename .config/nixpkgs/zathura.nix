{
  config,
  pkgs,
  ...
}:
# let
# 	stable = import <nixos-stable> { config.allowUnfree = true; };
# in
{
  programs.zathura = {
    enable = true;
    package = pkgs.zathura;
    options = {
      window-title-basename = "true";
      selection-clipboard = "clipboard";
      notification-error-bg = "#bf616a";
      notification-error-fg = "#d8dee9";
      notification-warning-bg = "#d08770";
      notification-warning-fg = "#4c566a";
      notification-bg = "#2e3440";
      notification-fg = "#d8dee9";
      completion-bg = "#2e3440";
      completion-fg = "#3b4252";
      completion-group-bg = "#2e3440";
      completion-group-fg = "#3b4252";
      completion-highlight-bg = "#4c566a";
      completion-highlight-fg = "#d8dee9";
      index-bg = "#2e3440";
      index-fg = "#d8dee9";
      index-active-bg = "#4c566a";
      index-active-fg = "#d8dee9";
      inputbar-bg = "#2e3440";
      inputbar-fg = "#d8dee9";
      statusbar-bg = "#2e3440";
      statusbar-fg = "#d8dee9";
      highlight-color = "#d08770";
      highlight-active-color = "#b48ead";
      default-bg = "#2e3440";
      default-fg = "#d8dee9";
      render-loading = true;
      render-loading-fg = "#2e3440";
      render-loading-bg = "#d8dee9";
      recolor-lightcolor = "#2e3440";
      recolor-darkcolor = "#d8dee9";
      adjust-open = "width";
      recolor = true;
    };
  };
}
