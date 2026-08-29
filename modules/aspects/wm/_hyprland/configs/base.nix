{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  settings = {
    env = [
      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_TYPE,wayland"
      "XDG_SESSION_DESKTOP,Hyprland"
    ];
    "$mod" = "SUPER";
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ]; # 1
    exec-once = [
      "${lib.getExe pkgs.swayidle} -w timeout 120 '${lib.getExe pkgs.swaylock} -f' timeout 300 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' before-sleep 'swaylock -f'"
      "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch cliphist store"
      "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch cliphist store"
      "hyprctl setcursor Nordzy-cursors 32"
      "awww-daemon"
      "waybar_auto_hide --side top --always-hidden &"
    ];
    exec = [
      "awww_rand_bg.sh $XDG_WALLPAPER_DIR"
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
      preserve_split = true;
      smart_split = true;
    };
    render = {
      expand_undersized_textures = false;
      direct_scanout = 0;
      cm_auto_hdr = 1;
    };
    misc = {
      mouse_move_enables_dpms = true;
      key_press_enables_dpms = true;
      animate_manual_resizes = false;
      enable_swallow = true;
    };

    ecosystem = {
      no_update_news = true;
      no_donation_nag = true;
      enforce_permissions = true;
    };
    windowrule = [
      "match:class kitty, match:title .*alsamixer.*, float on"
      "match:class kitty, match:title .*flameshot.*, float on"
      "match:class kitty,match:title .*nmtui.*, float on, size 480 480,"
      "match:class kitty,match:title .*Yazi.*, float on, size 960 680"
      "match:title .*Bluetooth.*, float on, size 720 680,"
      "match:title .*Bitwarden.*, float on, size 720 680,"
      "match:title .*Open.*, size 960 680"
      "match:title .*open.*, size 960 680"
    ];
    permission = [
      "${lib.getExe pkgs.grim}, screencopy, allow"
      "${lib.getExe pkgs.slurp}, screencopy, allow"
      "${lib.escapeRegex (lib.getExe config.programs.hyprlock.package)}, screencopy, allow"
      "/nix/store/[a-z0-9]{32}-xdg-desktop-portal-hyprland-wrapped-[0-9.]*/libexec/.xdg-desktop-portal-hyprland-wrapped, screencopy, allow"
      "${
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
      }/libexec/.xdg-desktop-portal-hyprland-wrapped, screencopy, allow"
      "${lib.getExe pkgs.flameshot}, screencopy, allow"

      "/nix/store/[a-z0-9]{32}-hyprland-([0-9.]*)\\+date^\\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$_([a-z0-9]{7})/bin/hyprctl, plugin, allow" # technically bad for sec, but since plugins must be explicitly specified, should be ok.
    ];
    #device = [
    # {
    #   name = "opentabletdriver-virtual-tablet";
    #   enabled = true;
    #   absolute_region_position = true;
    # }
    #];
    bind = [
      "$mod, B,exec, pkill -SIGUSR1 waybar || waybar"
      "$mod, RETURN, exec, kitty"
      "$mod, Q, killactive,"
      "$mod, M, exit,"
      "$mod, E, exec, kitty -e yazi"
      "$mod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
      "$mod, F, togglefloating"
      "$mod, R, exec, rofi -show drun"
      "$mod, L, exec, swaylock"
      "$mod, G, split:grabroguewindows"
      #"SUPER_SHIFT,S,exec, grim -g \"$(slurp -d)\" - | wl-copy"
      "SUPER_SHIFT,S,exec,flameshot gui --clipboard --accept-on-select"
      "SUPER_SHIFT,A,exec, flameshot screen --clipboard"
      ",XF86MonBrightnessUp,exec, brightnessctl -d \"$(brightnessctl --list | awk -F\"'\" '/class .backlight/ && /Device/ && $2 !~ /nvidia/ {print $2; exit}')\" s 5%+"
      ",XF86MonBrightnessDown,exec, brightnessctl -d \"$(brightnessctl --list | awk -F\"'\" '/class .backlight/ && /Device/ && $2 !~ /nvidia/ {print $2; exit}')\" s 5%-"
      ",XF86AudioMicMute, exec, amixer set Capture toggle"
      ",XF86AudioMute, exec, amixer set Master toggle"
      ",XF86AudioRaiseVolume, exec, amixer set Master 1%+"
      ",XF86AudioLowerVolume, exec, amixer set Master 1%-"
      "$mod, left, movefocus, l"
      "$mod, right, movefocus, r"
      "$mod, up, movefocus, u"
      "$mod, down, movefocus, d"
      "$mod, mouse_down, split:workspace, r-1"
      "$mod, mouse_up, split:workspace, r+1"
    ]
    ++ (
      # workspaces
      # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
      builtins.concatLists (
        builtins.genList (
          i:
          let
            ws = i + 1;
          in
          [
            "$mod, code:1${toString i}, split:workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, split:movetoworkspace, ${toString ws}"
          ]
        ) 9
      )
    );
    plugin = {
      hyprsplit = {
        num_workspaces = 10;
      };
    };
  };
  settingsLua =
    let
      lua = lib.generators.mkLuaInline;
      mod = "SUPER";

      # --- the helper function, as discussed ---
      # keys:   a plain "SUPER + X" style string
      # action: a raw Lua expression (as a string) - dispatcher call, function, etc.
      bind = keys: action: {
        _args = [
          keys
          (lua action)
        ];
      };

      # Two flavors of "run a shell command":
      #   exec - a *dispatcher* for use inside a bind (hl.dsp.exec_cmd)
      #   run  - a *statement* fired directly, e.g. at startup (hl.exec_cmd)
      # Both use Lua's [[ long-bracket ]] string form instead of "..." so that
      # commands containing single AND double quotes (like the brightness ones
      # below) don't need manual escaping.
      exec = cmd: "hl.dsp.exec_cmd([[${cmd}]])";
      run = cmd: "hl.exec_cmd([[${cmd}]])";

      on = event: body: {
        _args = [
          event
          (lua "function()\n${body}\nend")
        ];
      };

      swayidleCmd =
        "${lib.getExe pkgs.swayidle} -w "
        + "timeout 120 '${lib.getExe pkgs.swaylock} -f' "
        + "timeout 300 'hyprctl dispatch dpms off' "
        + "resume 'hyprctl dispatch dpms on' "
        + "before-sleep 'swaylock -f'";

      brightnessDevice = ''brightnessctl -d "$(brightnessctl --list | awk -F"'" '/class .backlight/ && /Device/ && $2 !~ /nvidia/ {print $2; exit}')"'';
    in
    {

      env = [
        {
          _args = [
            "XDG_CURRENT_DESKTOP"
            "Hyprland"
          ];
        }
        {
          _args = [
            "XDG_SESSION_TYPE"
            "wayland"
          ];
        }
        {
          _args = [
            "XDG_SESSION_DESKTOP"
            "Hyprland"
          ];
        }
      ];

      # ---- plain option categories -> merged into one hl.config({...}) ----
      config = {
        input = {
          kb_layout = "gb,us";
          kb_model = "at-translated-set-2-keyboard";
          kb_options = " grp:alt_shift_toggle";
          repeat_delay = 300;
          follow_mouse = 2;
          touchpad.natural_scroll = false;
          sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
        };

        general = {
          gaps_in = 1;
          gaps_out = 0;
          border_size = 1;
          "col.inactive_border" = "rgba(d8dee9dd)";
          "col.active_border" = "rgba(81a1c1aa)";
          layout = "dwindle";
          resize_on_border = true;
        };

        decoration = {
          blur = {
            enabled = true;
            new_optimizations = true;
            size = 5;
            passes = 1;
            xray = false;
          };
          rounding = 0;
          shadow.enabled = false;
        };

        animations = {
          enabled = true;
          workspace_wraparound = true;
        };

        dwindle = {
          preserve_split = true;
          smart_split = true;
        };

        render = {
          expand_undersized_textures = false;
          direct_scanout = 0;
          cm_auto_hdr = 1;
        };

        misc = {
          mouse_move_enables_dpms = true;
          key_press_enables_dpms = true;
          animate_manual_resizes = false;
          enable_swallow = true;
        };

        ecosystem = {
          no_update_news = true;
          no_donation_nag = true;
          enforce_permissions = true;
        };
      };

      # ---- bezier curves (was `bezier = "name, x1,y1,x2,y2"`) ----
      # hl.curve(name, { type = "bezier", points = {{x1,y1},{x2,y2}} })
      curve = [
        {
          _args = [
            "myBezier"
            (lua "{ type = \"bezier\", points = { {0.1, 0.9}, {0.1, 1.05} } }")
          ];
        }
        {
          _args = [
            "windowsSlideIn"
            (lua "{ type = \"bezier\", points = { {0.67, 0.08}, {0.34, 0.96} } }")
          ];
        }
        {
          _args = [
            "workspaceSlide"
            (lua "{ type = \"bezier\", points = { {0, 0.56}, {0.98, 0.29} } }")
          ];
        }
        {
          _args = [
            "fading"
            (lua "{ type = \"bezier\", points = { {0.17, 0.96}, {0.66, 0.94} } }")
          ];
        }
      ];

      # ---- animation leaves (was `animation = "leaf, on, speed, curve, style"`) ----
      # hl.animation({ leaf, enabled, speed, bezier, style? })
      animation = [
        {
          _args = [
            (lua ''{ leaf = "windows", enabled = true, speed = 5, bezier = "myBezier", style = "slide" }'')
          ];
        }
        {
          _args = [
            (lua ''{ leaf = "windowsOut", enabled = true, speed = 3, bezier = "default", style = "popin 70%" }'')
          ];
        }
        { _args = [ (lua ''{ leaf = "border", enabled = true, speed = 5, bezier = "default" }'') ]; }
        { _args = [ (lua ''{ leaf = "fade", enabled = true, speed = 3, bezier = "fading" }'') ]; }
        {
          _args = [
            (lua ''{ leaf = "workspaces", enabled = true, speed = 2, bezier = "workspaceSlide", style = "slide" }'')
          ];
        }
      ];

      # ---- startup commands (was exec-once = [...]) ----
      on = [
        (on "hyprland.start" ''
          ${run swayidleCmd}
          ${run "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch cliphist store"}
          ${run "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch cliphist store"}
          ${run "hyprctl setcursor Nordzy-cursors 32"}
          ${run "awww-daemon"}
          ${run "waybar_auto_hide --side top --always-hidden"}
        '')
      ];

      # ---- window rules ----
      # (was `windowrule = "match:x v, match:y v, ACTION VAL"`)
      window_rule = [
        { _args = [ (lua ''{ match = { class = "kitty", title = ".*alsamixer.*" }, float = true }'') ]; }
        { _args = [ (lua ''{ match = { title = "flameshot" }, float = true }'') ]; }
        {
          _args = [
            (lua ''{ match = { class = "kitty", title = ".*nmtui.*" }, float = true, size = "480 480" }'')
          ];
        }
        {
          _args = [
            (lua ''{ match = { class = "kitty", title = ".*Yazi.*" }, float = true, size = "960 680" }'')
          ];
        }
        { _args = [ (lua ''{ match = { title = ".*Bluetooth.*" }, float = true, size = "720 680" }'') ]; }
        { _args = [ (lua ''{ match = { title = ".*Bitwarden.*" }, float = true, size = "720 680" }'') ]; }
        { _args = [ (lua ''{ match = { title = ".*Open.*" }, size = "960 680" }'') ]; }
        { _args = [ (lua ''{ match = { title = ".*open.*" }, size = "960 680" }'') ]; }
      ];

      # ---- permissions (was `permission = "REGEX, TYPE, ACTION"`) ----
      # hl.permission(regex, type, action) - positional per the wiki
      permission = [
        {
          _args = [
            (lib.getExe pkgs.grim)
            "screencopy"
            "allow"
          ];
        }
        {
          _args = [
            (lib.getExe pkgs.slurp)
            "screencopy"
            "allow"
          ];
        }
        {
          _args = [
            (lib.escapeRegex (lib.getExe config.programs.hyprlock.package))
            "screencopy"
            "allow"
          ];
        }
        {
          _args = [
            "/nix/store/[a-z0-9]{32}-xdg-desktop-portal-hyprland-wrapped-[0-9.]*/libexec/.xdg-desktop-portal-hyprland-wrapped"
            "screencopy"
            "allow"
          ];
        }
        {
          _args = [
            "${
              inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
            }/libexec/.xdg-desktop-portal-hyprland-wrapped"
            "screencopy"
            "allow"
          ];
        }
        {
          _args = [
            (lib.getExe pkgs.flameshot)
            "screencopy"
            "allow"
          ];
        }
        # technically bad for sec, but since plugins must be explicitly specified, should be ok.
        {
          _args = [
            ''/nix/store/[a-z0-9]{32}-hyprland-([0-9.]*)\+date^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$_([a-z0-9]{7})/bin/hyprctl''
            "plugin"
            "allow"
          ];
        }
      ];

      # ---- keybinds ----
      bind = [
        (bind "${mod} + B" (exec "pkill -SIGUSR1 waybar || waybar"))
        (bind "${mod} + RETURN" (exec "kitty"))
        (bind "${mod} + Q" "hl.dsp.window.close()")
        (bind "${mod} + M" "hl.dsp.exit()")
        (bind "${mod} + E" (exec "kitty -e yazi"))
        (bind "${mod} + V" (exec "cliphist list | rofi -dmenu | cliphist decode | wl-copy"))
        (bind "${mod} + F" ''hl.dsp.window.float({ action = "toggle" })'')
        (bind "${mod} + R" (exec "rofi -show drun"))
        (bind "${mod} + L" (exec "swaylock"))

        (bind "SUPER + SHIFT + S" (exec "flameshot gui --clipboard --accept-on-select"))
        (bind "SUPER + SHIFT + A" (exec "flameshot screen --clipboard"))

        (bind "XF86MonBrightnessUp" (exec "${brightnessDevice} s 5%+"))
        (bind "XF86MonBrightnessDown" (exec "${brightnessDevice} s 5%-"))
        (bind "XF86AudioMicMute" (exec "amixer set Capture toggle"))
        (bind "XF86AudioMute" (exec "amixer set Master toggle"))
        (bind "XF86AudioRaiseVolume" (exec "amixer set Master 1%+"))
        (bind "XF86AudioLowerVolume" (exec "amixer set Master 1%-"))

        (bind "${mod} + left" ''hl.dsp.focus({ direction = "l" })'')
        (bind "${mod} + right" ''hl.dsp.focus({ direction = "r" })'')
        (bind "${mod} + up" ''hl.dsp.focus({ direction = "u" })'')
        (bind "${mod} + down" ''hl.dsp.focus({ direction = "d" })'')

        # mouse move/resize (was bindm)
        (bind "${mod} + mouse:272" "hl.dsp.window.drag()")
        (bind "${mod} + mouse:273" "hl.dsp.window.resize()")
      ];
    };

}
