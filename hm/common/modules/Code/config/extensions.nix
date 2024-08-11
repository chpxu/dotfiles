{pkgs, ...}: let
  fetchExt = ext: (pkgs.vscode-utils.extensionFromVscodeMarketplace ext);
  fetched = [
    # {
    #   name = "vscode-stylelint";
    #   publisher = "stylelint";
    #   version = "1.2.4";
    #   sha256 = "sha256-krJ8vC+przrHL3PIQrW0hQhL6ntp71nhudP4LxdDIno=";
    # }
    # {
    #   name = "python";
    #   publisher = "ms-python";
    #   version = "2024.4.0";
    #   sha256 = "";
    # }
    # {
    #   name = "pylint";
    #   publisher = "ms-python";
    #   version = "2023.10.1";
    #   sha256 = "";
    # }
    # {
    #   name = "vscode-pylance";
    #   publisher = "ms-python";
    #   version = "2023.9.12";
    #   sha256 = "sha256-2OaKkzHxE/X3x5nyObFVwi/dRT5ri9KuXY85v+aMxds=";
    # }
    # {
    #   name = "volar";
    #   publisher = "vue";
    #   version = "2.0.12";
    #   sha256 = "";
    # }
    # {
    #   name = "path-intellisense";
    #   publisher = "christian-kohler";
    #   version = "2.8.4";
    #   sha256 = "sha256-FEBYcjJHOwmxVHhhyxqOpk/V6hvtMkhkvLVpmJCMSZw=";
    # }
    # {
    #   name = "cpptools";
    #   publisher = "ms-vscode";
    #   version = "1.20.1";
    #   sha256 = "";
    # }
    {
      name = "remote-ssh";
      publisher = "ms-vscode-remote";
      version = "0.114.2024080815";
      sha256 = "sha256-F01eQR/A8X18K3CTxMS5D+7vgSVLb5L8w8qYkxgapEs=";
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
      version = "0.5.2024070409";
      sha256 = "sha256-YwmsZii8TvBhloNQi6mezusEf/SmIq3i1ZNyKN5j1sU=";
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
      # james-yu.latex-workshop
      # valentjn.vscode-ltex
      # eamodio.gitlens
      tamasfe.even-better-toml
      # Markup languages and CSS
      dotjoshjohnson.xml
      # formulahendry.auto-rename-tag
      # formulahendry.auto-close-tag
      # gencer.html-slim-scss-css-class-completion
      #  JS & TS
      # dbaeumer.vscode-eslint
      # esbenp.prettier-vscode
      # Shell
      timonwong.shellcheck
      # Python
      # ms-toolsai.jupyter
    ]
    ++ (map (x: (fetchExt x)) fetched);
}
