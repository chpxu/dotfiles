{pkgs, ...}: let
  pythonEnv = import ./definePythonEnv.nix;
  customPythonEnv = pkgs.python310.withPackages pythonEnv.my-python-pkgs;
in {
  home.packages = with pkgs; [
    pipenv
    customPythonEnv
  ];
}
