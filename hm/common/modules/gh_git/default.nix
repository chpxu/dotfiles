{pkgs, ...}: {
  programs.gh = {
    enable = true;
    package = pkgs.gh;
    gitCredentialHelper.enable = true;
    settings = {
      git_protocol = "https";
      editor = "code";
      aliases = {
        co = "pr checkout";
        pv = "pr view";
      };
      prompt = "enabled";
      version = 1;
    };
  };
  programs.git = {
    enable = true;
    package = pkgs.git;
    settings = {
      user = {
        name = "chpxu";
        email = "dev.chpxu@outlook.com";
      };
    };
  };
  programs.delta = {
    enable = true;
    options = {
      decorations = {
        commit-decoration-style = "bold yellow box ul";
        file-decoration-style = "none";
        file-style = "bold yellow ul";
      };
      features = "decorations";
      whitespace-error-style = "22 reverse";
    };
    enableGitIntegration = true;
  };
}
