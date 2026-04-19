_: {
  den.aspects.dev = {
    provides.neovim = {
      homeManager =
        { ... }:
        {
          programs.neovide.enable = true;
          programs.neovim = {
            enable = true;
            defaultEditor = true;
          };
        };
    };
    provides.vscode = {
      homeManager =
        { pkgs, ... }:
        {
          programs.vscode = with pkgs; {
            enable = true;
            package = vscode-fhs;
            profiles.default.extensions = (import ./_vscode/extensions.nix { inherit pkgs; }).extensions;
            userSettings = (import ./_vscode/settings.nix).settings;
          };
        };
    };
  };
}
