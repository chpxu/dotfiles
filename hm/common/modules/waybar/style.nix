let
  nord = import ../../nordtheme.nix;
in {
  style = ''
    /*Fix regression from 0.9.15*/
    button,
    label{
      all: unset;
    }
    label:disabled,
    button:disabled {
      color: inherit;
      background-image: none;
    }
    window#waybar {
      background: rgba(46, 52, 64, 0.9);
      color: ${nord.nord6};
      font-family: 'FiraCode Nerd Font', Inconsolata, sans-serif;
      font-weight: 400;
      font-size: 12px;
      border: none;
      border-radius: 0;
    }

    /*WORKSPACE STYLES*/
    #workspaces, #window {
      background: ${nord.nord1};
      margin: 5px 0 5px 5px;
      border-radius: 5px;
    }
    #workspaces button
    {
      color: ${nord.nord6};
      background: ${nord.nord3};
      border: none;
      padding: 0 10px 0 10px;
      margin: 2.5px 2.5px 2.5px 2.5px;
    }
    #workspaces button:hover {
      border: none;
      background: ${nord.nord1};
      box-shadow: none;
    }

    #workspaces button.focused {
      background: ${nord.nord0};
    }
    #workspaces button.urgent {
      transition: background 0.5s ease-in-out;
      background: ${nord.nord11};
    }
    #custom-launcher,
    #custom-keyboard {
      padding: 0 10px 0 10px;
      margin: 5px 0 5px 0;
      border-radius: 5px;
      color: inherit;
    }
    #window {
      margin-left: 5px;
      color: ${nord.nord15};
      padding-left: 5px;
      padding-right: 5px;
    }

    /*RIGHT-MODULES STYLES*/
    .modules-right {
      margin-right: 5px;
    }

    #cpu,
    #memory,
    #temperature,
    #backlight,
    #battery,
    #network,
    #state,
    #language,
    #tray,
    #clock,
    #idle_inhibitor,
    #pulseaudio
    {
      padding: 0 5px 0 5px;
      margin: 5px 0 5px 0;
      border-radius: 5px;
      color: inherit;
    }

    #battery,
    #backlight {
      color: ${nord.nord13};
    }
    #network {
      color: ${nord.nord8};
    }
    #cpu,
    #memory {
        color: ${nord.nord9};
    }
    #clock,
    #language,
    #tray {
        color: ${nord.nord15};
    }
    #pulseaudio {
        color: ${nord.nord10};
    }

    /*TRAY*/
    #tray > .needs-attention {
      background-color: ${nord.nord11}
    }

    /*Tooltips*/
    tooltip {
        background: ${nord.nord2};
        /* box-shadow: 1px 2px 5px #4c566a; */
        font-family: 'SauceCodePro Nerd Font', sans-serif;
        font-size: 16px;
        border-radius: 5px;
    }
    tooltip label {
        color: ${nord.nord6};
    }

    /*Taskbar*/
    #taskbar button {
        border: none;
        color: ${nord.nord6};
        padding: 0 10px 0 10px;
        margin: 0 2.5px 0 2.5px;
    }
    #taskbar button:hover,
    #custom-launcher:hover,
    #custom-keyboard:hover {
        transition: background-color 0.125s ease-in-out;
        background-color: ${nord.nord2};
    }
    #taskbar button.active {
        border-top: 2px solid ${nord.nord9};
        background-color: ${nord.nord1};
    }
    .modules-left {
        margin-left: 5px;
    }
    /* Custom Module: Start Button for launcher  */
    #custom-launcher {
        color: ${nord.nord10};
    }
    #custom-launcher:hover {
      background-color: ${nord.nord2};
    }
    #custom-separator {
      margin: 0 2.5px 0 2.5px;
      color: ${nord.nord4};
    }
  '';
}
