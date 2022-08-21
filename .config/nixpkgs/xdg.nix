{ config, pkgs, lib, ...}:
{
    xdg = {
        enable = true;
        cacheHome = ~/.cache;
        dataHome = ~/.local/share;
        stateHome = ~/.local/state;
        systemDirs = {
            config = [ "/etc/xdg" ];
            data =  [ "/usr/share" "/usr/local/share" ]; 
        };
        userDirs = {
            enable = true;
            createDirectories = true;
            desktop = "$HOME";
            documents = "$HOME/Documents";
            download = "$HOME/Downloads";
            music = "$HOME/Music";
            pictures = "$HOME/Pictures";
            videos = "$HOME/Videos";
            templates = "$HOME";
            publicShare = "$HOME";
            extraConfig = {
                XDG_MISC_DIR = "$HOME/Misc";
            };
        };
        mime.enable = true;
        mimeApps = {
            enable = true;
            # TO-DO: Mime associations where necessary
        };  
        configFile = {
            BetterDiscord = {
                source = ~/.config/BetterDiscord/themes;
                recursive = true;
            };
            light = {
                source = ~/.config/light;
                recursive = true;
            };
            neofetch = {
                source = ~/.config/neofetch;
                recursive = true;
            };
            swaylock = {
                source = ~/.config/swaylock;
                recursive = true;
            };
            vscodeSnippets = {
                source = ~/.config/Code/User/snippets/NT.code-snippets;
            };
            wayfireIni = {
                source = ~/.config/wayfire.ini;
            };
            wfShell = {
                source = ~/.config/wf-shell.ini;
            };
            wlogout = {
                source = ~/.config/wlogout;
                recursive = true;
            };
            wofi = {
                source = ~/.config/wofi;
                recursive = true;
            };
            xournalppcss = {
                source = ~/.config/xournalpp/xournalpp.css;
            };
            xournalpptoolbar = {
                source = ~/.config/xournalpp/toolbar.ini;
            };
            xournalppSettings = {
                source = ~/.config/xournalpp/settings.xml;
            };
            xournalppColours= {
                source = ~/.config/xournalpp/colornames.ini;
            };
        };
    };
}
