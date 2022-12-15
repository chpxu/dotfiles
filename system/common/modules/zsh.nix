{
  config,
  pkgs,
  ...
}: {
  # zsh
  programs.zsh = {
    enable = true;
    #loginExtra = "betterdiscordctl --d-modules ~/.config/discordcanary/0.0.136/modules/ install";
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    ohMyZsh = {
      enable = true;
      theme = "agnoster";
      customPkgs = with pkgs; [
        starship
      ];
    };
  };
}
