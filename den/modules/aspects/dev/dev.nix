{ den, ... }:
{
  den.aspects.dev = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          nil
          nixfmt
        ];
      };
    provides.neovim = {
      nixos = {
        programs.neovim = {
          withRuby = false;
          withPython3 = true;
        };
      };
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
      includes = [
        (den.provides.unfree [
          "vscode"
          "code"
        ])
      ];
      homeManager =
        { pkgs, ... }:
        {
          programs.vscode = {
            enable = true;
            package = pkgs.vscode-fhs;
            profiles.default.extensions = (import ./_vscode/extensions.nix { inherit pkgs; }).extensions;
            profiles.default.userSettings = (import ./_vscode/settings.nix).settings;
          };
        };
    };
  };
}
