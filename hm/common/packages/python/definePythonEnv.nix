{
  my-python-pkgs = python-packages:
    with python-packages; [
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
      # pytest-black
      # pytest
      # pandas
      #scikits-odes
      #sklearn-deap
      # scikit-learn
      # scikit-learn-extra
      # scikit-misc
    ];
}
