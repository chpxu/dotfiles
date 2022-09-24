{
  pkgs,
  config,
  lib,
  options,
  specialArgs,
  modulesPath,
}: {
  programs.zsh = {
    # dotDir = ".config/zsh";
    history = {
      path = "${config.xdg.configHome}/zsh/zsh_history";
    };
    shellAliases = {
      odsu = "onedrive --synchronize --upload-only";
      ods = "onedrive --synchronize --no-remote-delete";
      teams = "teams --enable-features=UseOzonePlatform --ozone-platform=wayland";
    };
    enableSyntaxHighlighting = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    initExtraBeforeCompInit = ''
      # p10k instant prompt
      P10K_INSTANT_PROMPT="$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh"
      [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"
    '';
    initExtra = ''
      source ${pkgs.powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    '';
    plugins = with pkgs; [
      {
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        name = "powerlevel10k";
        src = zsh-powerlevel10k;
      }
      {
        file = "p10k.zsh";
        name = "powerlevel10k-config";
        src = lib.cleanSource ./p10k-config;
      }
    ];
    loginExtra = ''
      wayfire
      betterdiscordctl --d-modules ~/.config/discordcanary/0.0.139/modules/install
    '';
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [
        "git"
        "gh"
        # "npm"
        # "zsh-interactive-cd"
      ];
    };
  };
}
