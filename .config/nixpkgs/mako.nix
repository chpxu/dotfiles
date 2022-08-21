{ config, pkgs, ...}:
{
    programs.mako = {
        enable = true;
       # package = pkgs.mako;
        actions = true;
        anchor = "top-right";
        backgroundColor = "#2e3440";
        borderSize = 2;
        borderRadius = 5;
        borderColor = "#d8dee9";
        textColor = "#d8dee9";
        defaultTimeout = 2500;
        ignoreTimeout = true;
        maxIconSize = 64;
        maxVisible = 10;
        markup = true;
        icons = true;
        iconPath = "/usr/share/icons:~/.local/share/icons:/usr/share/pixmaps";
        font = "FiraCode Nerd Font 10";
        height = 110;
        width = 300;
        sort = "-priority";
        layer = "overlay";
        padding = "10";
        progressColor = "over #a3be8c";
        extraConfig = ''
            [urgency=low]
            border-color=#88c0d0

            [urgency=normal]
            border-color=#ebcb8b

            [urgency=high]
            border-color=#d08770
            default-timeout=0

            [category=mpd]
            default-timeout=2000
            border-color=#bf616a
            group-by=category
        '';
    };
}
