let
  nord = import ../../../common/nordtheme.nix;
  root = import ./components/default.nix;
in {
  userContent =
    root.root
    + ''
          @-moz-document url("about:home"),
          url("about:newtab"),
          url("about:preferences"),
          url("about:config"),
          url("about:addons"),
          url("about:memory") {
            html,
            body,
            addon-page-header,
            .main-content {
                 background: ${nord.nord0} !important;
            }
        }
        /**/
        @-moz-document url("about:memory") {
            div:not([class="opsRow"]) {
                display: flex;
                flex-direction: row;
                justify-content: center;
                border-radius: 5px;
            }
            .opsRow,
            .section {
                background: var(--in-content-page-background) !important;
                color: var(--in-content-page-color) !important;
                padding: 20px !important;
            }
            .opsRowLabel {
                padding: 10px;
            }
            button {
                background: var(--in-content-button-background) !important;
                padding: 10px;
                margin: 5px !important;
                border: 1px solid var(--in-content-button-border-color) !important;
                border-radius: 5px;
            }
            button:hover {
                background: var(--in-content-button-background-hover) !important;
                border: 1px solid var(--in-content-button-border-color-hover) !important;

            }
            button:active {
                background: var(--in-content-button-background-active) !important;
                border: 1px solid var(--in-content-button-border-color-active) !important;
            }
        }
      @-moz-document url("man.archlinux.org/*") {
          body {
              color: ${nord.nord4};
          }
      }
    '';
}
