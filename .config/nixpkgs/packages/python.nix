{pkgs, ...}: let
  # my-python-pkgs = python-packages: with python-packages; [
  # 	pip
  # 	numpy
  # 	scipy
  # 	matplotlib
  # 	jupyter
  # 	ipython
  # 	ipykernel
  # 	mypy
  # 	#pylint
  # 	black
  # 	pytest-black
  # 	pytest
  # ];
  pythonEnv = import ./python/definePythonEnv.nix;
  customPythonEnv = pkgs.python310.withPackages pythonEnv.my-python-pkgs;
in {
  home.packages = with pkgs; [
    pipenv
    #python310Full
    customPythonEnv
    #black
  ];
}
