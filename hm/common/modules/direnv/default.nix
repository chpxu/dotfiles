{...}: {
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
    config = {
      whitelist = {
        prefix = [
          "$XDG_CONFIG_HOME/git_projects"
          "$XDG_CONFIG_HOME/OneDrive"
        ];
      };
    };
  };
}
