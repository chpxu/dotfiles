{ config, pkgs, ...}:
{
    services.swayidle = {
        enable = true;
        package = pkgs.swayidle;
        events = [
            { event = "before-sleep"; command = "swaylock"; }
            { event = "lock"; command = "swaylock"; }
        ];
        timeouts = [
            { timeout = 60; command = "swaylock -fF"; }
        ];
    };
    #     programs.swaylock.settings = {
    #         font = "FiraCode Nerd Retina";
    #         font-size = 50;
    #         indicator-radius = 384;
    #         indicator-thickness = 75;
    #         inside-color = "ffffff00";
    #         key-hl-color = "5e81ac";
    #         ring-color = "2e3440";
    #         line-uses-ring = true;
    #         separator-color = "e5e9f022";
    #         text-color = "d8dee9";
    #         text-clear-color = "d8dee9";
    #         text-caps-lock-color = "d8dee9";
    #         indicator-idle-visible = true;
    #         daemonize = true;
    #         image = /home/chunix/Pictures/blue_swirl.png;
    #         scaling = "fill";
    #         # swaylock-effects specific
    #         effect-blur = "20x2";
    #         grace = 1;
    #         fade-in = "0.2";
    #         indicator = true;
    #         clock = true;
    #         datestr="%F";
    #         timestr="%T";
    # };
}