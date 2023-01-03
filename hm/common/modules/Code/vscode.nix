{
  config,
  pkgs,
  ...
}: let
  pythonEnv = import ../../packages/python/definePythonEnv.nix;
  customPythonEnv = pkgs.python310.withPackages pythonEnv.my-python-pkgs;
in {
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
}
