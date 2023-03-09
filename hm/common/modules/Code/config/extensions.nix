{pkgs, ...}: {
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
      eamodio.gitlens
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
    ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "vscode-stylelint";
        publisher = "stylelint";
        version = "1.2.3";
        sha256 = "zs7tVrevvWNCpOrLyGIHeIpjRweVj9GG0KpV9j5NN0w=";
      }
      {
        name = "python";
        publisher = "ms-python";
        version = "2023.4.0";
        sha256 = "sha256-owQmPlTgcX6NmtfRrd9i8DMflP65smAmsedPYqV/Gzg=";
      }
      {
        name = "pylint";
        publisher = "ms-python";
        version = "2023.2.0";
        sha256 = "sha256-2OR64NvuX1ybEvYYN6o4CYa6YBltPOpA90vmNl8xIwI=";
      }
      {
        name = "vscode-pylance";
        publisher = "ms-python";
        version = "2023.3.21";
        sha256 = "sha256-A49/m3YL9Hy7AGvYrCnZ7GT4VLIqKka4GLsFEytjCUY=";
      }
      {
        name = "volar";
        publisher = "vue";
        version = "1.0.18";
        sha256 = "sha256-X4Wvu4jgLfbDE2DDb65iwcEE2uZb1vCTt2/zofMai9Q=";
      }
      {
        name = "path-intellisense";
        publisher = "christian-kohler";
        version = "2.8.4";
        sha256 = "sha256-FEBYcjJHOwmxVHhhyxqOpk/V6hvtMkhkvLVpmJCMSZw=";
      }
    ];
}
