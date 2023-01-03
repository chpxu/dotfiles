{pkgs, ...}: let
  pythonEnv = import ../../packages/python/definePythonEnv.nix;
  customPythonEnv = pkgs.python310.withPackages pythonEnv.my-python-pkgs;
in {
  programs.vscode = with pkgs;{
    enable = true;
    package = vscode.fhs;
    extensions = with vscode-extensions;
      [
        arcticicestudio.nord-visual-studio-code
        # Nix
        #bbenoist.nix # Better Nix Syntax highlighting
        jnoortheen.nix-ide
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
          version = "2022.20.1";
          sha256 = "sha256-UJOIhd5fsxRCw0a9oNsfY+SJ4Hjyi96DkgHRINZDr84=";
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
          version = "2022.12.21";
          sha256 = "sha256-tM1wtc6k60i5hdfYRVs0wtvC+0aiN3xNavrJLYWedAI=";
        }
        # {
        #   name = "jupyter";
        #   publisher = "ms-toolsai";
        #   version = "2022.11.1003381023";
        #   sha256 = "sha256-EKmpk1+OnHYogQHoVAUi1KDws3cx++9JNNwDfEXJdjE=";
        # }
        {
          name = "volar";
          publisher = "vue";
          version = "1.0.18";
          sha256 = "sha256-X4Wvu4jgLfbDE2DDb65iwcEE2uZb1vCTt2/zofMai9Q=";
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
        "python.defaultInterpreterPath" = "${customPythonEnv}/bin/python";
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
          "${customPythonEnv}/lib/python3.10/site-packages"
          "${customPythonEnv}/lib/python3.10/site-packages/matplotlib/"
          "${customPythonEnv}/lib/python3.10/site-packages/numpy/"
          "${customPythonEnv}/lib/python3.10/site-packages/scipy/"
        ];
        "python.analysis.extraPaths" = [
          "${customPythonEnv}/lib/python3.10/site-packages"
          "${customPythonEnv}/lib/python3.10/site-packages/matplotlib/"
          "${customPythonEnv}/lib/python3.10/site-packages/numpy/"
          "${customPythonEnv}/lib/python3.10/site-packages/scipy/"
        ];
        "pylint.args" = ["--rcfile" "./.pylintrc"];
        "python.formatting.provider" = "black";
        "python.formatting.blackPath" = "${pkgs.black}/bin/black";
        "pylint.interpreter" = [
          "${customPythonEnv}/bin/python"
        ];
      };
  };
}
