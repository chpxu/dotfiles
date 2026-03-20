{
  pkgs,
  lib,
  config,
  ...
}: {
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
      cm_fs_passthrough = 1;
      cm_auto_hdr = 1;
    };
    misc = {
      mouse_move_enables_dpms = true;
      key_press_enables_dpms = true;
      animate_manual_resizes = false;
      vfr = true;
    };

    ecosystem = {
      no_update_news = true;
      no_donation_nag = true;
      enforce_permissions = true;
    };
    windowrule = [
      "match:class kitty, match:title .*alsamixer.*, float on"
      "match:class kitty,match:title .*nmtui.*, float on, size 480 480,"
      "match:class kitty,match:title .*Yazi.*, float on, size 960 680"
      "match:title .*Bluetooth.*, float on, size 720 680,"
      "match:title .*Bitwarden.*, float on, size 720 680,"
      "match:title .*Open.*, size 960 680"
      "match:title .*open.*, size 960 680"
    ];
    permission = [
      "${lib.getExe pkgs.grim}, screencopy, allow"
      "${lib.escapeRegex (lib.getExe config.programs.hyprlock.package)}, screencopy, allow"
      "${pkgs.xdg-desktop-portal-hyprland}/libexec/.xdg-desktop-portal-hyprland-wrapped, screencopy, allow"
      "/nix/store/[a-z0-9]{32}-grim-[0-9.]*/bin/grim, screencopy, allow"
      "/nix/store/[a-z0-9]{32}-xdg-desktop-portal-hyprland-wrapped-[0-9.]*/libexec/.xdg-desktop-portal-hyprland-wrapped, screencopy, allow"
      "/nix/store/[a-z0-9]{32}-hyprland-([0-9.]*)\\+date^\\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$_([a-z0-9]{7})/bin/hyprctl, plugin, allow" # technically bad for sec, but since plugins must be explicitly specified, should be ok.
    ];
    bind =
      [
        "$mod, B,exec, pkill -SIGUSR1 waybar || waybar"
        "$mod, RETURN, exec, kitty"
        "$mod, Q, killactive,"
        "$mod, M, exit,"
        "$mod, E, exec, yazi"
        "$mod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        "$mod, F, togglefloating"
        "$mod, R, exec, rofi -show drun"
        "$mod, L, exec, swaylock"
        "$mod, G, split:grabroguewindows"
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
        "$mod, mouse_down, split:workspace, r-1"
        "$mod, mouse_up, split:workspace, r+1"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (
            i: let
              ws = i + 1;
            in [
              "$mod, code:1${toString i}, split:workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, split:movetoworkspace, ${toString ws}"
            ]
          )
          9)
      );
    plugin = {
      hyprsplit = {
        num_workspaces = 10;
      };
    };
  };
}
