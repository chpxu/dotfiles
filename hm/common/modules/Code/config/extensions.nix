{pkgs, ...}: let
  fetchExt = ext: (pkgs.vscode-utils.extensionFromVscodeMarketplace ext);
  fetched = [
    {
      name = "vscode-stylelint";
      publisher = "stylelint";
      version = "1.2.4";
      sha256 = "sha256-krJ8vC+przrHL3PIQrW0hQhL6ntp71nhudP4LxdDIno=";
    }
    {
      name = "python";
      publisher = "ms-python";
      version = "2023.16.0";
      sha256 = "sha256-JrXtDk3Cw8lxjSPd7RLF7u4FEEzjxoDvfT/YNQNLBFg=";
    }
    {
      name = "pylint";
      publisher = "ms-python";
      version = "2023.6.0";
      sha256 = "sha256-YDF6WJBQjv1+xbbzezCcGcv1BEefK0cYl1V1pqpC+98=";
    }
    {
      name = "vscode-pylance";
      publisher = "ms-python";
      version = "2023.9.12";
      sha256 = "sha256-2OaKkzHxE/X3x5nyObFVwi/dRT5ri9KuXY85v+aMxds=";
    }
    {
      name = "volar";
      publisher = "vue";
      version = "1.8.13";
      sha256 = "sha256-qD+BqjhayYCjcX2gGE8yLjxsAqcpQ231e0CAGI+KEsE=";
    }
    {
      name = "path-intellisense";
      publisher = "christian-kohler";
      version = "2.8.4";
      sha256 = "sha256-FEBYcjJHOwmxVHhhyxqOpk/V6hvtMkhkvLVpmJCMSZw=";
    }
    {
      name = "cpptools";
      publisher = "ms-vscode";
      version = "1.17.0";
      sha256 = "sha256-/q4cXLYgULPlHx50VE3t4xNNMI6x0Qp/haVSaWodI1Q=";
    }
    {
      name = "remote-ssh";
      publisher = "ms-vscode-remote";
      version = "0.102.0";
      sha256 = "sha256-YQ0Dy1C+xEGtwh0z97ypIMUq8D7PozVRb6xXUVZsjBw=";
    }
    {
      name = "remote-ssh-edit";
      publisher = "ms-vscode-remote";
      version = "0.86.0";
      sha256 = "sha256-JsbaoIekUo2nKCu+fNbGlh5d1Tt/QJGUuXUGP04TsDI=";
    }
    {
      name = "remote-explorer";
      publisher = "ms-vscode";
      version = "0.4.1";
      sha256 = "sha256-E0QsXIpCUjpoX6GNtzbI8/UzxTwWMpQpzVvsPhA+3t4=";
    }
  ];
in {
  extensions = with pkgs.vscode-extensions;
    [
      arcticicestudio.nord-visual-studio-code
      # Nix
      #bbenoist.nix # Better Nix Syntax highlighting
      jnoortheen.nix-ide
      kamadorueda.alejandra # Nix formatter
      mkhl.direnv
      # TeX stuff
      james-yu.latex-workshop
      valentjn.vscode-ltex
      # eamodio.gitlens
      tamasfe.even-better-toml
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
      ms-toolsai.jupyter
    ]
    ++ (map (x: (fetchExt x)) fetched);
}
