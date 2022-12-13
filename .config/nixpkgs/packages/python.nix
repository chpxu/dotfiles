{pkgs, ...}: let
  pythonEnv = import ./python/definePythonEnv.nix;
  customPythonEnv = pkgs.python310.withPackages pythonEnv.my-python-pkgs;
in {
  home.packages = with pkgs; [
    pipenv
    customPythonEnv
  ];
}
