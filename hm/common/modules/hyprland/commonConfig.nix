{
  commonConfig = ''
     # See https://wiki.hyprland.org/Configuring/Keywords/ for more

    # Execute your favorite apps at launch
    exec-once = waybar & hyprpaper

    exec = swayidle -w timeout 120 'swaylock -f' timeout 300 'hyprctl dispatch dpms off"' resume 'hyprctl dispatch dpms on"' before-sleep 'swaylock -f'
    exec-once = wl-paste -w cliphist store
    exec-once = hyprctl setcursor Nordzy-cursors 32

    $cliphistShow = cliphist list | bemenu -p 'cliphist' -m  -1 -l 20 -H 40 -W 0.5 -i -f -w -n --nb '#3b4252' --nf '#eceff4' --tb '#3b4252' --tf '#eceff4' --fb '#2e3440' -ff '##eceff4'  --hb '#434c5e"  --hf '#bf616a' --sb '#4c566a' --fn 'FiraCode Nerd Font 12' | cliphist decode | wl-copy
    $cliphistDel = cliphist list | bemenu -p 'cliphist' -m  -1 -l 20 -H 40 -W 0.5 -i -f -w -n --nb '#3b4252' --nf '#eceff4' --tb '#3b4252' --tf '#eceff4' --fb '#2e3440' -ff '#eceff4'  --hb '##434c5e"  --hf '#bf616a' --sb '#4c566a' --fn 'FiraCode Nerd Font 12' | cliphist delete
    # Source a file (multi-file configs)
    # source = ~/.config/hypr/myColors.conf

    # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
    input {
        kb_layout = gb,us
        # kb_variant =
        kb_model = at-translated-set-2-keyboard
        kb_options = grp:alt_shift_toggle
        # kb_rules =
        repeat_delay = 300
        follow_mouse = 2

        touchpad {
            natural_scroll = no
        }

        sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
    }

    general {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        gaps_in = 1
        gaps_out = 0
        border_size = 2
        col.active_border = rgba(eceff4ee)
        col.inactive_border = rgba(e5e9f0aa)

        layout = dwindle
    }

    decoration {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = 2
        # blur = no
        blur_size = 3
        blur_passes = 2
        blur_new_optimizations = on

        drop_shadow = false
        shadow_range = 2
        shadow_render_power = 1
        col.shadow = rgba(1a1a1aee)
    }

    animations {
        enabled = yes

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = myBezier, 0.1, 0.9, 0.1, 1.05
        bezier = windowsSlideIn, 0.67, 0.08, 0.34, 0.96
        bezier = workspaceSlide, 0, 0, 1, 1
        bezier = fading, 0.17, 0.96, 0.66, 0.94
        animation = windows, 1, 5, myBezier, slide
        #animation = windowsIn 1, 3, windowsSlideIn
        animation = windowsOut, 1, 3, default, popin 70%
        animation = border, 1, 5, default
        animation = fade, 1, 3, fading
        animation = workspaces, 1, 2, workspaceSlide, slide
        #use_resize_transitions = off
    }

    dwindle {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = yes # you probably want this
    }

    master {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        new_is_master = true
    }

    gestures {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = on
        workspace_swipe_forever = true
    }

    # Example per-device config
    # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
    # device:epic mouse V1 {
    #     sensitivity = -0.5
    # }

    # Example windowrule v1
    # windowrule = float, ^(kitty)$
    # Example windowrule v2
    # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
    # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more


    # See https://wiki.hyprland.org/Configuring/Keywords/ for more
    $mainMod = SUPER

    # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
    bind = $mainMod, RETURN, exec, kitty
    bind = $mainMod, Q, killactive,
    bind = $mainMod, M, exit,
    bind = $mainMod, E, exec, krusader
    bind = $mainMod, V, exec, $cliphistShow
    bind = $mainMod, F, togglefloating,
    bind = $mainMod, R, exec, wofi --show=run
    bind = $mainMod, P, pseudo, # dwindle
    bind = $mainMod, J, togglesplit, # dwindle
    bind = $mainMod, L, exec, swaylock

    # Monitor Brightness
    bind = ,XF86MonBrightnessUp,exec, light -A 5
    bind = ,XF86MonBrightnessDown,exec, light -U 5

    # ScreenShotting
    bind = ,Print,exec, grim
    bind = $mainMod,Print,exec, grim -g "$(slurp)"

    # Audio
    bind = ,XF86AudioMicMute, exec, amixer set Capture toggle
    bind = ,XF86AudioMute, exec, amixer set Master toggle
    bind = ,XF86AudioRaiseVolume, exec, amixer set Master 5%+
    bind = ,XF86AudioLowerVolume, exec, amixer set Master 5%-

    # Move focus with mainMod + arrow keys
    bind = $mainMod, left, movefocus, l
    bind = $mainMod, right, movefocus, r
    bind = $mainMod, up, movefocus, u
    bind = $mainMod, down, movefocus, d

    # Switch workspaces with mainMod + [0-9]
    bind = $mainMod, 1, workspace, 1
    bind = $mainMod, 2, workspace, 2
    bind = $mainMod, 3, workspace, 3
    bind = $mainMod, 4, workspace, 4
    bind = $mainMod, 5, workspace, 5
    bind = $mainMod, 6, workspace, 6
    bind = $mainMod, 7, workspace, 7
    bind = $mainMod, 8, workspace, 8
    bind = $mainMod, 9, workspace, 9
    bind = $mainMod, 0, workspace, 10

    # Move active window to a workspace with mainMod + SHIFT + [0-9]
    bind = $mainMod SHIFT, 1, movetoworkspace, 1
    bind = $mainMod SHIFT, 2, movetoworkspace, 2
    bind = $mainMod SHIFT, 3, movetoworkspace, 3
    bind = $mainMod SHIFT, 4, movetoworkspace, 4
    bind = $mainMod SHIFT, 5, movetoworkspace, 5
    bind = $mainMod SHIFT, 6, movetoworkspace, 6
    bind = $mainMod SHIFT, 7, movetoworkspace, 7
    bind = $mainMod SHIFT, 8, movetoworkspace, 8
    bind = $mainMod SHIFT, 9, movetoworkspace, 9
    bind = $mainMod SHIFT, 0, movetoworkspace, 10

    # Scroll through existing workspaces with mainMod + scroll
    bind = $mainMod, mouse_down, workspace, e+1
    bind = $mainMod, mouse_up, workspace, e-1

    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = $mainMod, mouse:272, movewindow
    bindm = $mainMod, mouse:273, resizewindow

    misc {
        mouse_move_enables_dpms = on
        animate_manual_resizes = off
        enable_swallow = on
        swallow_regex = "kitty"
        # no_vfr = false
    }
  '';
}
