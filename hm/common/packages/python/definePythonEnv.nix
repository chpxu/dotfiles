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
      pytest-black
      pytest
      pyzmq
    ];
}
