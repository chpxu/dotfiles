{pkgs, ...}: {
  extensions = with pkgs.vscode-extensions;
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
        version = "2022.19.13351014";
        sha256 = "sha256-GvE4tWTnLMjDFvV3qGGZB6uDm/+FSbocD9ecDRZxwpQ=";
      }
      {
        name = "pylint";
        publisher = "ms-python";
        version = "2022.7.13271012";
        sha256 = "sha256-w2ygHMLX2Cd4zW8TtS1enPrg2N4ftCXliq5kCH2Hp5g=";
      }
      {
        name = "vscode-pylance";
        publisher = "ms-python";
        version = "2022.12.11";
        sha256 = "sha256-KWb+8ltLCbg1YUces607N89owT2QZ0ImvhM6mPiu8iA=";
      }
      {
        name = "jupyter";
        publisher = "ms-toolsai";
        version = "2022.11.1003381023";
        sha256 = "sha256-EKmpk1+OnHYogQHoVAUi1KDws3cx++9JNNwDfEXJdjE=";
      }
      # {
      #   name = "vscode-custom-css";
      #   publisher = "be5invis";
      #   version = "7.1.0";
      #   sha256 = "";
      # }
    ];
}
