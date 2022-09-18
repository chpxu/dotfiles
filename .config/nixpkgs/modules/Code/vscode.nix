{
  config,
  pkgs,
  ...
}: {
  programs.vscode = with pkgs; {
    enable = true;
    package = vscode;
    extensions = with vscode-extensions;
      [
        arcticicestudio.nord-visual-studio-code
        # Nix
        bbenoist.nix # Better Nix Syntax highlighting
        kamadorueda.alejandra # Nix formatter
        # TeX stuff
        james-yu.latex-workshop
        valentjn.vscode-ltex
        eamodio.gitlens
        #bungcip.better-toml
        # Markup languages and CSS
        dotjoshjohnson.xml
        formulahendry.auto-rename-tag
        formulahendry.auto-close-tag
        gencer.html-slim-scss-css-class-completion
        #  JS & TS
        dbaeumer.vscode-eslint
        esbenp.prettier-vscode
        # Shell
        timonwong.shellcheck
        # Python
        ms-python.python
        ms-toolsai.jupyter
        ms-python.vscode-pylance
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "vscode-stylelint";
          publisher = "stylelint";
          version = "1.2.3";
          sha256 = "zs7tVrevvWNCpOrLyGIHeIpjRweVj9GG0KpV9j5NN0w=";
        }
      ];
    userSettings = (import ./config/settings.nix).settings;
  };
}
