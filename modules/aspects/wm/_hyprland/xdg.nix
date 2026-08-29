{
  config,
  hostname,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  wayland.windowManager.hyprland =
    let
      base =
        (import ./configs/base.nix {
          inherit
            pkgs
            config
            lib
            inputs
            ;
        }).settingsLua;
      extraSettings = (import ./configs/${hostname}.nix { inherit lib; }).settingsLua;
      touchpad = (import ./configs/touchpad.nix).settings;
    in
    {
      enable = true;
      plugins = [
        inputs.hyprsplit.packages.${pkgs.stdenv.hostPlatform.system}.hyprsplit
      ];
      configType = "lua";
      systemd.enable = true;
      systemd.enableXdgAutostart = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      settings = lib.recursiveUpdate base (extraSettings);
      extraConfig = ''
        hl.exec_cmd([[awww_rand_bg.sh $XDG_WALLPAPER_DIR]])
      '';

      # ---------------------------------------------------------------------
      # hyprsplit
      # ---------------------------------------------------------------------
      extraLuaFiles = {
        "hyprsplit/init" = {
          autoLoad = false;
          content = builtins.readFile "${
            inputs.hyprsplit.packages.${pkgs.stdenv.hostPlatform.system}.hyprsplitlua
          }/share/hyprsplit/init.lua";
        };
        "hyprsplit-setup" =
          let
            mod = "SUPER";
            num_workspaces = 9;
          in
          {
            autoLoad = true;
            content = ''
              local hs = require("hyprsplit")
              hs.config({ num_workspaces = ${toString num_workspaces} })

              hl.bind("${mod} + G", hs.dsp.grab_rogue_windows())
              hl.bind("${mod} + mouse_down", hs.dsp.focus({ workspace = "r-1" }))
              hl.bind("${mod} + mouse_up", hs.dsp.focus({ workspace = "r+1" }))

              for i = 1, ${toString num_workspaces} do
                local key = "code:1" .. tostring(i - 1)
                hl.bind("${mod} + " .. key, hs.dsp.focus({ workspace = i }))
                hl.bind("${mod} + SHIFT + " .. key, hs.dsp.window.move({ workspace = i, follow = false }))
              end
              hl.bind("SUPER + " .. "d", hs.dsp.workspace.swap_monitors({ monitor1 = "current", monitor2 = "+1" }))

            '';
          };
      };
    };

  xdg.configFile = {
    # "hypr/yoga.conf" = {
    #   source =
    #     if hostname == "yoga" then
    #       config.lib.file.mkOutOfStoreSymlink ./. + "/configs/yoga.conf"
    #     else
    #       config.lib.file.mkOutOfStoreSymlink ./. + "/configs/default.conf";
    #   target = "hypr/yoga.conf";
    # };

    # "hypr/hyprpaper.conf" = {
    #   source = config.lib.file.mkOutOfStoreSymlink ./. + "/hyprpaper.conf";
    #   target = "hypr/hyprpaper.conf";
    # };
  };
}
