let
  nord = import ../../../../common/nordtheme.nix;
in {
  root = ''
      :host, :root {
      /*--blue-40: #88c0d0;
      --blue-50: #81a1c1;
      --blue-60: #5e81ac;
      --blue-70: #345da4;
      --blue-80: #1e336a;
      --grey-30: #d8dee9;
      --grey-60: #4a4a4f;FieldText
      --grey-90-a10: rgba(76, 86, 106, 0.1);
      --grey-90-a20: rgba(76, 86, 106, 0.2);
      --grey-90-a30: rgba(76, 86, 106, 0.3);
      --grey-90-a50: rgba(76, 86, 106, 0.5);
      --grey-90-a60: rgba(76, 86, 106, 0.6);
      --green-50: #a3be8c;
      --green-60: #659260;
      --green-70: #4c834a;
      --green-80: #006504;
      --green-90: #215226;
      --orange-50: #d08770;
      --red-40: #bf616a;
      --red-50: #cd4a66;
      --red-60: #d70022;
      --red-70: #a72e38;
      --red-80: #532021;
      --red-90: #371a19;
      --yellow-50: #ebcb8b;
      --yellow-60: #8f833e;
      --yellow-60-a30: rgba(215, 182, 0, 0.3);
      --yellow-70: #a47f00;
      --yellow-80: #715100;
      --yellow-90: #3e2800;*/
      --shadow-10: 0 1px 4px var(--grey-90-a10);
      --shadow-30: 0 4px 16px var(--grey-90-a10);
      --card-padding: 16px;
      --card-shadow: var(--shadow-10);
      --card-outline-color: var(--grey-30);
      --card-shadow-hover: var(--card-shadow), 0 0 0 5px var(--card-outline-color);
      accent-color: var(--in-content-accent-color);
      --in-content-page-background: ${nord.nord0} !important;
      --in-content-page-color: ${nord.nord6} !important;
      --in-content-deemphasized-text: ${nord.nord5} !important;
      --in-content-box-background: ${nord.nord1} !important;
      --in-content-border-color: ${nord.nord4} !important;
      --in-content-border-hover: ${nord.nord5} !important;
      --in-content-border-invalid: ${nord.nord11} !important;
      --in-content-error-text-color: ${nord.nord11} /*#FF9AA2*/ !important;
      --in-content-button-background: ${nord.nord1} !important;
      --in-content-button-background-hover: ${nord.nord3} !important;
      --in-content-button-background-active: ${nord.nord2} !important;
      --in-content-icon-color: var(--in-content-page-color) !important;
      --in-content-primary-button-text-color: var(--in-content-page-color) !important;
      --in-content-primary-button-background: var(--in-content-button-background) !important;
      --in-content-primary-button-background-hover: var(--in-content-button-background-hover) !important;
      --in-content-primary-button-background-active: var(--in-content-button-background-active) !important;
      --in-content-danger-button-background: ${nord.nord11} !important;
      --in-content-danger-button-background-hover: ${nord.nord11 + "c6"};
      --in-content-danger-button-background-active: ${nord.nord11 + "ee"};
      --in-content-table-background: var(--in-content-page-background) !important;
      --in-content-accent-color: var(--in-content-primary-button-background);
      --in-content-accent-color-active: var(--in-content-primary-button-background-hover);
      --in-content-link-color: ${nord.nord4};
      --in-content-link-color-hover: ${nord.nord6};
      --in-content-link-color-active: ${nord.nord5};
      --in-content-link-color-visited: ${nord.nord10};
      --card-outline-color: var(--grey-60);
      --dialog-warning-text-color: var(--red-40);
      scrollbar-color: ${nord.nord9 + "72"} rgba(20,20,25,.3) !important;
      --in-content-text-color: var(--in-content-page-color) !important;
      --in-content-box-background-odd: var(--in-content-page-background) !important;
      --in-content-box-border-color: color-mix(in srgb, currentColor 41%, transparent);
      --in-content-box-info-background: ${nord.nord1} !important;
      --in-content-item-hover: color-mix(in srgb, var(--in-content-primary-button-background) 20%, transparent) !important;
      --in-content-item-hover-text: var(--in-content-page-color) !important;
      --in-content-item-selected: var(--in-content-primary-button-background) !important;
      --in-content-item-selected-text: var(--in-content-primary-button-text-color) !important;
      --in-content-accent-color: ${nord.nord4};
      --in-content-accent-color-active: ${nord.nord4};
      --in-content-focus-outline-color: var(--in-content-primary-button-background);
      --in-content-table-border-color: var(--in-content-page-color);
      --in-content-table-header-background: var(--in-content-primary-button-background);
      --in-content-table-header-color: var(--in-content-primary-button-text-color);
      --in-content-sidebar-width: 240px;
      --dialog-warning-text-color: var(--red-60);
      --checkbox-border-color: var(--in-content-box-border-color);
      --checkbox-unchecked-bgcolor: var(--in-content-button-background);
      --checkbox-unchecked-hover-bgcolor: var(--in-content-button-background-hover);
      --checkbox-unchecked-active-bgcolor: var(--in-content-button-background-active);
      --checkbox-checked-bgcolor: var(--in-content-primary-button-background);
      --checkbox-checked-color: var(--in-content-primary-button-text-color);
      --checkbox-checked-border-color: transparent;
      --checkbox-checked-hover-bgcolor: var(--in-content-primary-button-background-hover);
      --checkbox-checked-active-bgcolor: var(--in-content-primary-button-background-active);
      #color-scheme: light;
    }
    /*:root {
      color: -moz-DialogText;
      font: message-box;
    }*/
    :root {
      --default-focusring-width: 2px;
      --default-focusring: var(--default-focusring-width) dotted;
      --focus-outline-width: 2px;
      --focus-outline-color: AccentColor;
      --focus-outline: var(--focus-outline-width) solid var(--focus-outline-color);
      --focus-outline-inset: calc(-1 * var(--focus-outline-width));
      --focus-outline-offset: 2px;
      --arrowpanel-background: ${nord.nord0};
      --arrowpanel-color: FieldText;
      --arrowpanel-border-color: ThreeDShadow;
      --arrowpanel-border-radius: 8px;
      --arrowpanel-padding: 16px;
      --arrowpanel-dimmed: color-mix(in srgb, currentColor 17%, transparent);
      --arrowpanel-dimmed-further: color-mix(in srgb, currentColor 30%, transparent);
      --panel-description-color: GrayText;
      --panel-disabled-color: GrayText;
      --popup-notification-body-width: calc(31em - calc(2 * var(--arrowpanel-padding)));
      --toolbarbutton-icon-fill: currentColor;
      /* --toolbar-field-background-color: Field; */
      --toolbar-field-background-color: ${nord.nord0};
      --toolbar-field-color: FieldText;
      --toolbar-field-border-color: ThreeDShadow;
      --toolbar-field-focus-background-color: Field;
      --toolbar-field-focus-color: FieldText;
    }'';
}
