{ config, pkgs, lib, ...}:
{
    nixpkgs.config.packageOverrides = pkgs: {
        nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
          inherit pkgs;
        };
    };
    imports = [ ./common/nordtheme.nix ];
    programs.firefox = {
        enable = true;
        package = pkgs.firefox-wayland;
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            bitwarden
            tabcenter-reborn
            ublock-origin
        ];
        profiles = {
            chunix = {
                id = 0;
                name = "chunix";
                isDefault = true;
                path = "g0yz2hb9.default";
                settings = {
                    "accessibility.typeaheadfind.flashBar" = 0;
                    "app.normandy.first_run" = false;
                    "app.normandy.migrationsApplied" = 12;
                    "app.shield.optoutstudies.enabled" = false;
                    "browser.aboutConfig.showWarning" = false;
                    "browser.bookmarks.addedImportButton" = true;
                    "browser.bookmarks.editDialog.confirmationHintShowCount" = 1;	
                    "browser.bookmarks.restore_default_bookmarks" = false;
                    "browser.contentblocking.category" = "standard";
                    "browser.download.always_ask_before_handling_new_types" = true;	
                    "browser.download.panel.shown" = true;
                    "browser.download.useDownloadDir" = false;
                    "browser.download.viewableInternally.typeWasRegistered.avif
                    " = true;
                    "browser.download.viewableInternally.typeWasRegistered.webp"= true;
                    "browser.engagement.ctrlTab.has-used" = true;
                    "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons"= false;
                    "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features"= false;
                    "browser.theme.toolbar-theme" = 0;
                    "datareporting.healthreport.uploadEnabled" = false;
                    "datareporting.policy.dataSubmissionPolicyAcceptedVersion" = 2;
                    "devtools.debugger.prefs-schema-version" = 11;
                    "devtools.everOpened" = true;
                    "doh-rollout.balrog-migration-done" = true;
                    "doh-rollout.disable-heuristics" =true;
                    "doh-rollout.doneFirstRun" =true;
                    "doh-rollout.home-region" = "GB";
                    "dom.forms.autocomplete.formautofill" = false;
                    "dom.security.https_only_mode" = true;
                    "dom.security.https_only_mode_ever_enabled" = true;	
                    "dom.security.https_only_mode_ever_enabled_pbm" = true;
                    "dom.webgpu.enabled" = true;
                    "extensions.activeThemeID" = "{758478b6-29f3-4d69-ab17-c49fe568ed80}";                    "extensions.blocklist.pingCountVersion" = -1;
                    "extensions.databaseSchema" = 35;
                    "extensions.formautofill.creditCards.enabled" = false;
                    "extensions.getAddons.databaseSchema" = 6;
                    "extensions.pictureinpicture.enable_picture_in_picture_overrides" = true;
                    "extensions.systemAddonSet" = "{'schema':1,'addons':{}}";
                    "extensions.ui.dictionary.hidden" =true;
                    "extensions.ui.extension.hidden" = false;
                    "extensions.ui.locale.hidden" = true;
                    "extensions.ui.sitepermission.hidden" = true;
                    "extensions.webcompat.enable_shims" = true;
                    "extensions.webcompat.perform_injections" = true;
                    "extensions.webcompat.perform_ua_overrides" = true;
                    "fission.experiment.max-origins.qualified" = true;
                    "font.name.monospace.x-western" = "FiraCode Nerd Font";
                    "font.name.serif.x-western" = "Times Newer Roman";
                    "gecko.handlerService.defaultHandlersVersion" = 1;
                    "gfx.canvas.accelerated" = true;
                    "gfx.font_rendering.ahem_antialias_none" = true;
                    "gfx.webgpu.force-enabled" = true;
                    "gfx.webrender.all" = true;
                    "gfx.webrender.compositor" = true;
                    "gfx.webrender.enabled" = true;
                    "layout.css.osx-font-smoothing.enabled" = true;
                    "layout.css.prefers-color-scheme.content-override" = 0;
                    "layout.spellcheckDefault" = 0;
                    "media.eme.enabled" = true;
                    "media.ffmpeg.vaapi.enabled" = true;
                    "media.gmp-gmpopenh264.abi" = "x86_64-gcc3";
                    "media.gmp-gmpopenh264.version" = "1.8.1.2";
                    "media.gmp-widevinecdm.abi" = "x86_64-gcc3";
                    "media.gmp-widevinecdm.version" = "4.10.2449.0";
                    "media.gmp.storage.version.observed" = 1;
                    "media.videocontrols.picture-in-picture.video-toggle.has-used" = true;
                    "network.dns.disablePrefetch" = true;
                    "network.http.speculative-parallel-limit" = 0;
                    "network.predictor.enabled" = false;
                    "network.prefetch-next" = false;
                    "network.trr.mode" = 2;
                    "network.trr.uri" = "https://mozilla.cloudflare-dns.com/dns-query";
                    "pdfjs.enabledCache.state" = true;
                    "pdfjs.migrationVersion" = 2;
                    "privacy.donottrackheader.enabled" = true;
                    "privacy.purge_trackers.date_in_cookie_database" = 0;
                    "privacy.sanitize.pending" = "[{'id':'newtab-container','itemsToClear':[],'options':{}}]";
                    "privacy.userContext.enabled" = true;
                    "privacy.userContext.extension" = "tabcenter-reborn@ariasuni";
                    "privacy.userContext.ui.enabled" = true;
                    "webgl.dxgl.enabled"  = true;
                    "webgl.force-enabled "= true;
                };
                userChrome = ''
                    @import url(./verticaltabs.css);
                    @import url(./oneline.css);
                    @import url(./userContent.css);
                    /* === CUSTOM MODIFICATIONS=== */

                    /* Start Page */
                    /* Search box */
                    input.fake-editable  {
                        background-color: ${config.nordtheme.nord0};
                    }

                    /* Tabs Toolbar transparent background so the tabs float */
                    /*#TabsToolbar {
                        background: #2e344000 !important;
                    }*/


                    /* Override Firefox Nordic Theme context menu styling */
                    /* Toolbox colors */
                    #navigator-toolbox {
                        border: 0 !important;
                        background: none !important;
                    }

                    #nav-bar, #PersonalToolbar, #toolbar-menubar, #TabsToolbar, findbar {
                        border: 0 !important;
                        background: ${config.nordtheme.nord0} !important;
                        border-bottom: 1px solid none !important;
                    }
                    #nav-bar:-moz-window-inactive,
                    #PersonalToolbar:-moz-window-inactive, #toolbar-menubar:-moz-window-inactive, 
                    #TabsToolbar:-moz-window-inactive, findbar:-moz-window-inactive {
                        background: ${config.nordtheme.nord0} !important;
                        border-bottom: 1px solid none !important;
                    }
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
                    }
                '';
                userContent = ''
                    :host, :root {
                        --blue-40: #88c0d0;
                        --blue-50: #81a1c1;
                        --blue-60: #5e81ac;
                        --blue-70: #345da4;
                        --blue-80: #1e336a;
                        --grey-30: #d8dee9;
                        --grey-60: #4a4a4f;
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
                        --yellow-90: #3e2800;
                        --shadow-10: 0 1px 4px var(--grey-90-a10);
                        --shadow-30: 0 4px 16px var(--grey-90-a10);
                        --card-padding: 16px;
                        --card-shadow: var(--shadow-10);
                        --card-outline-color: var(--grey-30);
                        --card-shadow-hover: var(--card-shadow), 0 0 0 5px var(--card-outline-color);
                        accent-color: var(--in-content-accent-color);
                        --in-content-page-background: ${config.nordtheme.nord0} !important;
                        --in-content-page-color: ${config.nordtheme.nord6} !important;
                        --in-content-deemphasized-text: ${config.nordtheme.nord5} !important;
                        --in-content-box-background: ${config.nordtheme.nord1} !important;
                        --in-content-border-color: ${config.nordtheme.nord4} !important;
                        --in-content-border-hover: ${config.nordtheme.nord5} !important;
                        --in-content-border-invalid: ${config.nordtheme.nord11} !important;
                        --in-content-error-text-color: ${config.nordtheme.nord11} /*#FF9AA2*/ !important;
                        --in-content-button-background: ${config.nordtheme.nord1} !important;
                        --in-content-button-background-hover: ${config.nordtheme.nord3} !important;
                        --in-content-button-background-active: ${config.nordtheme.nord2} !important;
                        --in-content-icon-color: var(--in-content-page-color) !important;
                        --in-content-primary-button-text-color: var(--in-content-page-color) !important;
                        --in-content-primary-button-background: var(--in-content-button-background) !important;
                        --in-content-primary-button-background-hover: var(--in-content-button-background-hover) !important;
                        --in-content-primary-button-background-active: var(--in-content-button-background-active) !important;
                        --in-content-danger-button-background: ${config.nordtheme.nord11} !important;
                        --in-content-danger-button-background-hover: ${config.nordtheme.nord11 + "c6"};
                        --in-content-danger-button-background-active: ${config.nordtheme.nord11 + "ee"};
                        --in-content-table-background: var(--in-content-page-background) !important;
                        --in-content-accent-color: var(--in-content-primary-button-background);
                        --in-content-accent-color-active: var(--in-content-primary-button-background-hover);
                        --in-content-link-color: var(--in-content-primary-button-background);
                        --in-content-link-color-hover: var(--in-content-primary-button-background-hover);
                        --in-content-link-color-active: var(--in-content-primary-button-background-active);
                        --in-content-link-color-visited: var(--in-content-link-color);
                        --card-outline-color: var(--grey-60);
                        --dialog-warning-text-color: var(--red-40);
                        scrollbar-color: ${config.nordtheme.nord9 + "72"} rgba(20,20,25,.3) !important;
                        --in-content-text-color: var(--in-content-page-color) !important;
                        --in-content-box-background-odd: var(--in-content-page-background) !important;
                        --in-content-box-border-color: color-mix(in srgb, currentColor 41%, transparent);
                        --in-content-box-info-background: ${config.nordtheme.nord1} !important;
                        --in-content-item-hover: color-mix(in srgb, var(--in-content-primary-button-background) 20%, transparent) !important;
                        --in-content-item-hover-text: var(--in-content-page-color) !important;
                        --in-content-item-selected: var(--in-content-primary-button-background) !important;
                        --in-content-item-selected-text: var(--in-content-primary-button-text-color) !important;
                        --in-content-accent-color: ${config.nordtheme.nord4};
                        --in-content-accent-color-active: ${config.nordtheme.nord4};
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
                        color-scheme: dark;
                    }
                    :root {
                        color: -moz-DialogText;
                        font: message-box;
                    }
                    :root {
                        --default-focusring-width: 2px;
                        --default-focusring: var(--default-focusring-width) dotted;
                        --focus-outline-width: 2px;
                        --focus-outline-color: AccentColor;
                        --focus-outline: var(--focus-outline-width) solid var(--focus-outline-color);
                        --focus-outline-inset: calc(-1 * var(--focus-outline-width));
                        --focus-outline-offset: 2px;
                        --arrowpanel-background: ${config.nordtheme.nord0};
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
                        --toolbar-field-background-color: ${config.nordtheme.nord0} !important;
                        --toolbar-field-color: FieldText;
                        --toolbar-field-border-color: ThreeDShadow;
                        --toolbar-field-focus-background-color: Field;
                        --toolbar-field-focus-color: FieldText;
                    }
                    @-moz-document url("about:home"), url("about:newtab") {
                        body {
                            background-image: url("img/nord-peaks.png") !important;
                            background-repeat: no-repeat !important;
                            background-position: center !important;
                            background-size: cover !important;
                            background-attachment: fixed !important;
                        }
                    }

                    @-moz-document url("about:preferences"), url("about:config"), url("about:addons") {
                        body,
                        addon-page-header,
                        .main-content {
                            background: ${config.nordtheme.nord0} !important;
                        }
                    }
                    
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
                '';
            };
        };
    };
}