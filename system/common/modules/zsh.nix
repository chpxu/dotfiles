{lib, ...}: {
  # zsh
  programs.zsh = {
    enable = true;
    #loginExtra = "betterdiscordctl --d-modules ~/config/discordcanary/00136/modules/ install";
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    # ohMyZsh = {
    #   enable = true;
    #   theme = "agnoster";
    # };
  };
  programs.starship = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ./starship/startship.toml);
  };
}
