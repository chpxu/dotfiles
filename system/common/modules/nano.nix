{
  programs.nano = {
    syntaxHighlight = true;
    nanorc = ''
      set autoindent
      set afterends
      set atblanks
      set constantshow
      unset casesensitive
      set fill 80
      set linenumbers
      set minibar
      unset nowrap
      set softwrap
      set tabsize 2
    '';
  };
}
