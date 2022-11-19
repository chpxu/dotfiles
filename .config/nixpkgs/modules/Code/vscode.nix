{
  config,
  pkgs,
  ...
}: {
  programs.vscode = with pkgs; {
    enable = true;
    package = vscode.fhs;
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
        #ms-python.python
        #ms-toolsai.jupyter
        #ms-python.vscode-pylance
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
          version = "2022.17.12921047";
          sha256 = "sha256-opv1fh4v+i8kBZJ1iNmzNQbOQuDnlVoJZZmiSYraO5k=";
        }
        {
          name = "pylint";
          publisher = "ms-python";
          version = "2022.5.12851049";
          sha256 = "sha256-Sp3S1dh0L1EEIFNRFVUn11ah/wg1CmEyY8eC5HhRerE=";
        }
        {
          name = "vscode-pylance";
          publisher = "ms-python";
          version = "2022.10.31";
          sha256 = "sha256-z0VOYO/UZkZtQCPixvfLnR/mZvOsx2g8LzqiaZEnTsw=";
        }
        {
          name = "jupyter";
          publisher = "ms-toolsai";
          version = "2022.10.1002861107";
          sha256 = "y+6REmYPn8YqYaVWJSHE+4aKGxcUldto9EcH6ebM7og=";
        }
        # {
        #   name = "vscode-custom-css";
        #   publisher = "be5invis";
        #   version = "7.1.0";
        #   sha256 = "";
        # }
      ];
    userSettings =
      (import ./config/settings.nix).settings
      // {
        "ltex.ltex-ls.path" = "${pkgs.ltex-ls}";
        "python.defaultInterpreterPath" = "${pkgs.python310Full}/bin/python";
        "python.pipenvPath" = "${pkgs.pipenv}/bin/pipenv";
        "python.linting.mypyEnabled" = true;
        "python.linting.mypyPath" = "${pkgs.python310Packages.mypy}/bin/mypy";
        "python.linting.mypyArgs" = [
          "--follow-imports=silent"
          #"--ignore-missing-imports",
          "--show-column-numbers"
          "--no-pretty"
        ];
        "python.linting.pylintPath" = "${pkgs.pylint}/bin/pylint";
        "python.autoComplete.extraPaths" = [
          "${pkgs.python310Packages.pip}/bin/pip"
          "${pkgs.python310Packages.scipy}/lib/python3.10/site-packages/scipy"
          "${pkgs.python310Packages.numpy}/lib/python3.10/site-packages/numpy"
          "${pkgs.python310Packages.matplotlib}/lib/python3.10/site-packages/matplotlib"
          "${pkgs.python310}/lib/python3.10/site-packages/"
        ];
        "python.analysis.extraPaths" = [
          "${pkgs.python310Packages.scipy}/lib/python3.10/site-packages/scipy"
          "${pkgs.python310Packages.numpy}/lib/python3.10/site-packages/numpy"
          "${pkgs.python310Packages.matplotlib}/lib/python3.10/site-packages/matplotlib"
          "${pkgs.python310.pkgs.numpy}/lib/python3.10/site-packages/"
          "${pkgs.python310}/lib/python3.10/site-packages/numpy"
          "${pkgs.python310}/lib/python3.10/site-packages/scipy"
          "${pkgs.python310}/lib/python3.10/site-packages/matplotlib"
        ];
        "pylint.args" = ["--rcfile" "./.pylintrc"];
        "python.formatting.provider" = "black";
        "python.formatting.blackPath" = "${pkgs.black}/bin/black";
        "pylint.interpreter" = [
          "${pkgs.python310}/bin/python"
        ];
      };
  };
}
