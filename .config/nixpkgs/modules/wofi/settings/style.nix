let
  theme = import ../../../common/nordtheme.nix;
  ten = "10";
  tw = "20";
in {
  style = ''
    #window {
      background-color: ${theme.nord0};
      font-family: "FiraCode Nerd Font", monospace;
      position: top;
      border-radius: 0;
    }
    #input image {
      color: ${theme.nord14};
      margin-left: ${ten}px;
      margin-right: ${ten}px;

    }
    #input {
      margin-bottom: ${tw}px;
      margin-left: ${tw}px;
      margin-right: ${tw}px;
      margin-top: ${tw}px;
      background-color: ${theme.nord0};
      border: 1px solid ${theme.nord13};
      border-radius: 0px;
      transition: 0.125s ease-in-out;
      padding: ${ten}px 0;
    }
    #input:focus {
      background-color: ${theme.nord10 + "1A"};
      margin-left: ${tw}px;
      margin-right: ${tw}px;
      transition: 0.125s ease-in-out;
    }
    label {
      color: ${theme.nord4};
      /* transition: 0.5s ease-in-out; */
      padding: ${ten}px ${ten}px ${ten}px ${ten}px;
      margin-left: ${ten}px;
      margin-right: ${ten}px;

    }
    #text:selected,
    #entry:selected {
      color: ${theme.nord4};
      background-color: ${theme.nord1};
      border: none;
      outline: none;
    }
    #outer-box {
      /* border: 1px solid ${theme.nord4}; */
      border-left: 2px solid black;
      border-right: 2px solid black;
      border-bottom: 2px solid black;
      outline: none;
    }
  '';
}
