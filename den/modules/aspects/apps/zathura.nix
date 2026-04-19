_: {
  den.aspects.zathura = {
    homeManager =
      {
        pkgs,
        nordtheme,
        ...
      }:
      {
        programs.zathura = {
          enable = true;
          package = pkgs.zathura;
          options = {
            window-title-basename = "true";
            selection-clipboard = "clipboard";
            notification-error-bg = "${nordtheme.nord11}";
            notification-error-fg = "${nordtheme.nord4}";
            notification-warning-bg = "${nordtheme.nord12}";
            notification-warning-fg = "${nordtheme.nord6}";
            notification-bg = "${nordtheme.nord0}";
            notification-fg = "${nordtheme.nord4}";
            completion-bg = "${nordtheme.nord0}";
            completion-fg = "${nordtheme.nord1}";
            completion-group-bg = "${nordtheme.nord0}";
            completion-group-fg = "${nordtheme.nord1}";
            completion-highlight-bg = "${nordtheme.nord3}";
            completion-highlight-fg = "${nordtheme.nord4}";
            index-bg = "${nordtheme.nord0}";
            index-fg = "${nordtheme.nord4}";
            index-active-bg = "${nordtheme.nord3}";
            index-active-fg = "${nordtheme.nord4}";
            inputbar-bg = "${nordtheme.nord0}";
            inputbar-fg = "${nordtheme.nord4}";
            statusbar-bg = "${nordtheme.nord0}";
            statusbar-fg = "${nordtheme.nord4}";
            highlight-color = "${nordtheme.nord1105}";
            highlight-active-color = "${nordtheme.nord1505}";
            default-bg = "${nordtheme.nord0}";
            default-fg = "${nordtheme.nord4}";
            render-loading = true;
            render-loading-fg = "${nordtheme.nord0}";
            render-loading-bg = "${nordtheme.nord4}";
            recolor-lightcolor = "${nordtheme.nord0}";
            recolor-darkcolor = "${nordtheme.nord4}";
            adjust-open = "width";
            # recolor = true;
          };
        };
      };
  };
}
