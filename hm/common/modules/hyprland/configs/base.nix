{pkgs, ...}: {
  settings = {
    "$mod" = "SUPER";
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ]; #
    exec-once = [
      "${pkgs.swayidle}/bin/swayidle -w timeout 120 '${pkgs.swaylock}/bin/swaylock -f' timeout 300 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' before-sleep 'swaylock -f'"
      "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch cliphist store"
      "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch cliphist store"
      "hyprctl setcursor Nordzy-cursors 32"
    ];
    input = {
      kb_layout = "gb,us";
      kb_model = "at-translated-set-2-keyboard";
      kb_options = " grp:alt_shift_toggle";
      repeat_delay = 300;
      follow_mouse = 2;
      touchpad = {
        natural_scroll = false;
      };

      sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
    };
    general = {
      # See https://wiki.hyprland.org/Configuring/Variables/ for more

      gaps_in = 1;
      gaps_out = 0;
      border_size = 1;
      "col.inactive_border" = "rgba(d8dee9dd)";
      "col.active_border" = "rgba(81a1c1aa)";
      layout = "dwindle";
      resize_on_border = true;
    };
    decoration = {
      # See https://wiki.hyprland.org/Configuring/Variables/ for more
      blur = {
        enabled = true;
        new_optimizations = true;
        size = 5;
        passes = 1;
        xray = false;
      };
      rounding = 0;
      shadow = {
        enabled = false;
      };
    };
    animations = {
      enabled = true;
      bezier = [
        "myBezier, 0.1, 0.9, 0.1, 1.05"
        "windowsSlideIn, 0.67, 0.08, 0.34, 0.96"
        "workspaceSlide, 0,0.56,0.98,0.29"
        "fading, 0.17, 0.96, 0.66, 0.94"
      ];
      animation = [
        "windows, 1, 5, myBezier, slide"
        "windowsOut, 1, 3, default, popin 70%"
        "border, 1, 5, default"
        "fade, 1, 3, fading"
        "workspaces, 1, 2, workspaceSlide, slide"
      ];
      workspace_wraparound = true;
    };

    dwindle = {
      # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
      pseudotile = true; # master switch for pseudotiling.
      preserve_split = true;
    };
    render = {
      expand_undersized_textures = false;
      direct_scanout = 0;
    };
    misc = {
      mouse_move_enables_dpms = true;
      key_press_enables_dpms = true;
      animate_manual_resizes = false;
      vfr = true;
      vrr = 2;
    };

    experimental = {
      xx_color_management_v4 = true;
    };

    ecosystem = {
      no_update_news = true;
      no_donation_nag = true;
      enforce_permissions = true;
    };
    windowrule = [
      "float,class:kitty,title:.*alsamixer.*"
      "float,size 480 480, class:kitty,title:.*nmtui.*"
      "float,size 960 680, class:kitty,title:.*Yazi.*"
      "float,size 960 680,title:.*Bluetooth.*"
      "float,size 720 680,title:.*Bitwarden.*"
      "float,title:.*Open.*"
      "float,title:.*open.*"
    ];
    permission = [
      "/nix/store/[a-z0-9]{32}-grim-[0-9.]*/bin/grim, screencopy, allow"
      "/nix/store/[a-z0-9]{32}-xdg-desktop-portal-hyprland-[0-9.]*/libexec/.xdg-desktop-portal-hyprland-wrapped, screencopy, allow"
      "/nix/store/[a-z0-9]{32}-hyprland-([0-9.]*)\\+date^\\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$_([a-z0-9]{7})/bin/hyprctl, plugin, allow" # technically bad for sec, but since plugins must be explicitly specified, should be ok.
    ];
    bind =
      [
        "$mod,W ,exec, pkill -SIGUSR1 waybar || waybar"
        "$mod, RETURN, exec, kitty"
        "$mod, Q, killactive,"
        "$mod, M, exit,"
        "$mod, E, exec, yazi"
        "$mod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        "$mod, F, togglefloating"
        "$mod, R, exec, rofi -show drun"
        "$mod, L, exec, swaylock"
        "SUPER_SHIFT,S,exec, grim -g \"$(slurp -d)\" - | wl-copy"
        ",XF86MonBrightnessUp,exec, light -A 5"
        ",XF86MonBrightnessDown,exec, light -U 5"
        ",XF86AudioMicMute, exec, amixer set Capture toggle"
        ",XF86AudioMute, exec, amixer set Master toggle"
        ",XF86AudioRaiseVolume, exec, amixer set Master 1%+"
        ",XF86AudioLowerVolume, exec, amixer set Master 1%-"
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
        "ALT, Tab, hyprexpo:expo, toggle"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (
            i: let
              ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          9)
      );
    plugin = {
      hyprexpo = {
        columns = 3;
        gap_size = 5;
        bg_col = "rgb(111111)";
        workspace_method = "center current"; # [center/first] [workspace] e.g. first 1 or center m+1

        gesture_distance = 300; # how far is the "max" for the gesture
      };
    };

    # bind =
  };
}
