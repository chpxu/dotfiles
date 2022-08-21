{ config, pkgs, ...}:

{
    programs.kitty = {
        enable = true;
        package = pkgs.kitty;
        font = {
             name = "FiraCode Nerd Font";
             size = 12;
        };
        settings = {
            adjust_line_height = 0;
            adjust_column_width = -1;
            disable_ligatures = "never";
            cursor = "#d8dee9";
            cursor_text_color = "background";
            cursor_beam_thickness = 1;
            cursor_blink_interval = 0;
            url_color = "#0087bd";
            url_style  = "straight";
            open_url_with = "default";
            detect_urls = true;
            copy_on_select = false;
            strip_trailing_spaces = "smart";
            input_delay = 10;
            sync_to_monitor = true;
            enable_audio_bell = false;
            visual_bell_duration = 0;
            window_border_width = 0;
            draw_minimal_borders = false;
            window_margin_width = 0;
            single_window_margin_width = -1;
            window_padding_width = 0;
            placement_strategy = "center";
            active_border_color = "#a3be8c";
            inactive_border_color = "#d8dee9";
            inactive_text_alpha = "0.8";
            hide_window_decorations = true;
            confirm_os_window_close = 0;
            tab_bar_edge = "bottom";
            tab_bar_margin_width = 1;
            tab_bar_margin_height = "0.0 10.0";
            tab_bar_style = "powerline";
            tab_bar_align = "left";
            tab_bar_min_tabs = 2;
            tab_powerline_style = "angled";
            tab_activity_symbol = "none";
            tab_title_template = "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{title}";
            active_tab_foreground = "#4c566a";
            active_tab_background  = "#81a1c1";
            active_tab_font_style = "bold";
            inactive_tab_foreground = "#d8dee9";
            inactive_tab_background = "#3b4252";
            inactive_tab_font_style = "normal";
            foreground = "#eceff4";
            background = "#2e3440";
            background_opacity = "0.9";
            selection_background = "#e5e9f0";
            color0 = "#2e3440";
            color1 = "#bf616a";
            color2 = "#a3be8c";
            color3 = "#ebcb8b";
            color4 = "#5e81ac";
            color5 = "#b48ead";
            color6 = "#8fbcbb";
            color7 = "#eceff4";
            clipboard_control = "write-clipboard write-primary read-clipboard-ask read-primary-ask";
            allow_hyperlinks = "ask";
            shell_integration = "enabled";
            tabs = true;

        };
        keybindings = {
            "ctrl+tab+1" = "goto_tab 1";
            "ctrl+tab+2" = "goto_tab 2";
            "mod+k" =  "clear_terminal clear active";
            "kitty_mod" = "ctrl+shift";
            "kitty_mod+q" = "close_tab";
            "kitty_mod+t" = "new_tab";
            "kitty_mod+tab" = "previous_tab";
            "ctrl+tab" = "next_tab";
            "kitty_mod+v" = "paste_from_clipboard";
            "kitty_mod+c" = "copy_to_clipboard";
        };
    };
}