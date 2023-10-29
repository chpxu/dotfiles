{
  config,
  pkgs,
  ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };
  xdg.configFile = {
    # "rofi/themes/nord.rasi" = {
    #   text = config.lib.file.mkOutOfStoreSymlink ./. + "./nord.rasi";
    #   target = "rofi/themes/nord.rasi";
    # };qqhrgduwj
    "rofi/config.rasi" = {
      text = ''
                configuration {
                  location: 0;
                  matching: "fuzzy";
                  modi: "combi";
                  combi-modes: ["window","drun","run"];
                  no-steal-focus: true;
                  normal-window: true;
                  show-icons: true;
                  terminal: "${pkgs.kitty}/bin/kitty";
                  xoffset: 0;
                  yoffset: 0;
                  click-to-exit: true;
                  display-ssh:    "";
                  display-run:    "";
                  display-drun:   "";
                  display-window: "";
                  display-combi:  "";
                  }
                  @theme"/dev/null"
                                  /**
                 * Nordic rofi theme
                 * Adapted by undiabler <undiabler@gmail.com>
                 * Modified by chpxu <dev.chpxu@outlook.com>
                 * Nord Color palette imported from https://www.nordtheme.com/
                 *
                 */


                * {
                	nord0: #2e3440;
                	nord1: #3b4252;
                	nord2: #434c5e;
                	nord3: #4c566a;

                	nord4: #d8dee9;
                	nord5: #e5e9f0;
                	nord6: #eceff4;

                	nord7: #8fbcbb;
                	nord8: #88c0d0;
                	nord9: #81a1c1;
                	nord10: #5e81ac;
                	nord11: #bf616a;

                	nord12: #d08770;
                	nord13: #ebcb8b;
                	nord14: #a3be8c;
                	nord15: #b48ead;

                  fg:  @nord9;
                  bg:  @nord0;
                  transparent: rgba(46,52,64,0);
                  highlight: underline bold #eceff4;
                }
        window {
            location: center;
            anchor:   center;
            transparency: "screenshot";

            border:  0px;
            border-radius: 6px;

            background-color: @transparent;
            spacing: 0;
            children:  [mainbox];
            orientation: horizontal;
        }

        mainbox {
            spacing: 0;
            children: [ inputbar, message, listview ];
        }

        message {
            color: @nord0;
            padding: 5;
            border-color: @fg;
            border:  0px 2px 2px 2px;
            background-color: @nord7;
        }

        inputbar {
            color: @nord6;
            padding: 11px;
            background-color: @nord1;

            border: 1px;
            border-radius:  6px 6px 0px 0px;
            border-color: @nord10;
        }

        entry, prompt, case-indicator {
            text-font: inherit;
            text-color:inherit;
            background-color: @nord1;
        }
        prompt {
            margin: 0px 1em 0em 0em;
            background-color: @nord0;
        }

        listview {
            padding: 8px;
            border-radius: 0px 0px 6px 6px;
            border-color: @nord10;
            border: 0px 1px 1px 1px;
            background-color: @nord0;
            dynamic: false;
        }

        element {
            padding: 3px;
            vertical-align: 0.5;
            border-radius: 4px;
            background-color: transparent;
            color: @fg;
            text-color: rgb(216, 222, 233);
        }

        element selected.normal {
        	background-color: @nord7;
        	text-color: #2e3440;
        }

        element-text, element-icon {
            background-color: inherit;
            text-color:       inherit;
        }

        button {
            padding: 6px;
            color: @fg;
            horizontal-align: 0.5;

            border: 2px 0px 2px 2px;
            border-radius: 4px 0px 0px 4px;
            border-color: @fg;
        }

        button selected normal {
            border: 2px 0px 2px 2px;
            border-color: @fg;
        }
                error-message {
                  background-color: @nord0;
                  color: @nord11;
                }
      '';
      target = "rofi/config.rasi";
    };
  };
}
