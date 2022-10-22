{pkgs, ...}: 
let 
	my-python-pkgs = python-packages: with python-packages; [
		pip
		numpy
		scipy
		matplotlib
		jupyter
		ipython
		ipykernel
		mypy
		#pylint
		black
		pytest-black
		pytest
	];
	customPythonEnv = pkgs.python310.withPackages my-python-pkgs;
in
{
  home.packages = with pkgs;
    [
      pipenv
      #python310Full
      customPythonEnv
      #black
    ];
    #++ (with pkgs.python310Packages; [
      # Python
    #  pip
    #  jupyter_core
    #  ipython
    #  ipykernel
    #  numpy
    #  scipy
    #  matplotlib
    #]);
}
