let
  nord = import ../../../nordtheme.nix;
in {
  userChrome = ''
    @import url(./verticaltabs.css);
    @import url(./oneline.css);
    /*@import url(./components/menupopup/menupopup.css);*/
    /* === CUSTOM MODIFICATIONS=== */

    /* Start Page */
    /* Search box */
    input.fake-editable  {
        background-color: ${nord.nord0};
    }

    /* Toolbox colors */
    #navigator-toolbox {
        border: 0 !important;
        background: none !important;
    }

    #nav-bar, #PersonalToolbar, #toolbar-menubar, #TabsToolbar, findbar {
        border: 0 !important;
        background: ${nord.nord0} !important;
        border-bottom: 1px solid none !important;
    }
    #nav-bar:-moz-window-inactive,
    #PersonalToolbar:-moz-window-inactive, #toolbar-menubar:-moz-window-inactive,
    #TabsToolbar:-moz-window-inactive, findbar:-moz-window-inactive {
        background: ${nord.nord0} !important;
        border-bottom: 1px solid none !important;
    }
    /*
    #context-navigation {
        padding: 4px 8px 8px !important;
    }
    #context-navigation > menuitem > .menu-iconic-left {
        margin: auto !important;
    }
    #context-navigation menuitem {
        --toolbarbutton-active-background: transparent !important;
        --toolbarbutton-hover-background: transparent !important;
    }
    menuitem, menupopup menu {
        -moz-appearance: none !important;
        padding: 4px 8px !important;
        margin: 0 !important;
    }

    menuitem[type="checkbox"] image, menuitem[type="radio"] image {
        visibility: visible !important;
    }

    menuitem[disabled="true"]:hover, menupopup menu[disabled="true"]:hover {
        background: transparent !important;
    }*/
  '';
}
