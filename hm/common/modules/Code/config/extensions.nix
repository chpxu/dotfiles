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
      version = "2023.12.0";
      sha256 = "sha256-JwduTEwOpfSi+Br1hLd9ush+RK+Yg7XVHHvpQKPa4V4=";
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
      version = "2023.7.21";
      sha256 = "sha256-dbGSC1WpFOj2/eJc0XyQgMVM8KJtM7LthKGIcSgLrWo=";
    }
    {
      name = "volar";
      publisher = "vue";
      version = "1.8.5";
      sha256 = "sha256-AEIQFglW6RiWusiciMUeXgMs+bIERI/oDY6GUEQTPKg=";
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
      bungcip.better-toml
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
