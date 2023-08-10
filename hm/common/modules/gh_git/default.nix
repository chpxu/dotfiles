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
    };
  };
  programs.git = {
    enable = true;
    package = pkgs.git;
    userName = "chpxu";
    userEmail = "dev.chpxu@outlook.com";
    delta = {
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
    };
  };
}
