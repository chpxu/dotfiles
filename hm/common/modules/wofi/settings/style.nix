{colour-palette}: let
  ten = "10";
  tw = "20";
in {
  style = ''
    #window {
      background-color: ${colour-palette.nord0};
      font-family: "FiraCode Nerd Font", monospace;
      position: top;
      border-radius: 0;
    }
    #input image {
      color: ${colour-palette.nord14};
      margin-left: ${ten}px;
      margin-right: ${ten}px;

    }
    #input {
      margin-bottom: ${tw}px;
      margin-left: ${tw}px;
      margin-right: ${tw}px;
      margin-top: ${tw}px;
      background-color: ${colour-palette.nord0};
      border: 1px solid ${colour-palette.nord13};
      border-radius: 0px;
      transition: 0.125s ease-in-out;
      padding: ${ten}px 0;
    }
    #input:focus {
      background-color: ${colour-palette.nord10 + "1A"};
      margin-left: ${tw}px;
      margin-right: ${tw}px;
      transition: 0.125s ease-in-out;
    }
    label {
      color: ${colour-palette.nord4};
      /* transition: 0.5s ease-in-out; */
      padding: ${ten}px ${ten}px ${ten}px ${ten}px;
      margin-left: ${ten}px;
      margin-right: ${ten}px;

    }
    #text:selected,
    #entry:selected {
      color: ${colour-palette.nord4};
      background-color: ${colour-palette.nord1};
      border: none;
      outline: none;
    }
    #outer-box {
      outline: none;
    }
  '';
}
