{ config, pkgs, lib, ...}:
let
    
in
{
    nixpkgs.config.packageOverrides = pkgs: {
        nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
          inherit pkgs;
        };
    };
    imports = [ (lib.attrValues nur.repos.rycee.firefox-addons) ];
    programs.firefox = {
        enable = true;
        package = pkgs.firefox-wayland;
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            bitwarden
            tabcenter-reborn
            ublock-origin
            #theme-nord-polar-night
        ];
        profiles = {
            chunix = {
                id = 1;
                name = "chunix";
                path = ~/.mozilla/firefox/chunix;
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
            };
        };
    };
}