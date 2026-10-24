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
    in
    {
      enable = true;
      #plugins = [
      #  inputs.hyprsplit.packages.${pkgs.stdenv.hostPlatform.system}.hyprsplit.hyprsplitlua
      #];
      configType = "lua";
      systemd.enable = true;
      systemd.enableXdgAutostart = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      settings = lib.recursiveUpdate base extraSettings;
      extraConfig = ''
hl.on("window.open", function(w)
    if w.class ~= "firefox" then return end
    if w.initial_title ~= "Mozilla Firefox" then return end

    local ff_windows = hl.get_windows({ class = "firefox" })
    if #ff_windows <= 1 then return end

    hl.dispatch(hl.dsp.window.float({ action = "set", window = w }))

    local sub
    sub = hl.on("window.title", function(tw)
        if tw.address ~= w.address then return end
        if tw.title == ""
            or tw.title == "Mozilla Firefox"
            or tw.title == "about:blank"
            or tw.title:match("^about:.*Mozilla Firefox$") then return end

        sub:remove()

        if tw.title:match("^Extension:") then
            hl.dispatch(hl.dsp.window.resize({ x = 800, y = 600, window = tw }))
            hl.dispatch(hl.dsp.window.center({ window = tw }))
            hl.dispatch(hl.dsp.focus({ window = tw }))
        else
            hl.dispatch(hl.dsp.window.float({ action = "unset", window = tw }))
        end
    end)
end)
      '';

      # ---------------------------------------------------------------------
      # hyprsplit
      # ---------------------------------------------------------------------
      #extraLuaFiles = {
      #  "hyprsplit/init" = {
      #    autoLoad = false;
      #    content = builtins.readFile "${
      #      inputs.hyprsplit.packages.${pkgs.stdenv.hostPlatform.system}.hyprsplitlua
      #    }/share/hyprsplit/init.lua";
      #  };
      #  "hyprsplit-setup" =
      #    let
      #      mod = "SUPER";
      #      num_workspaces = 9;
      #    in
      #    {
      #      autoLoad = true;
      #      content = ''
      #        local hs = require("hyprsplit")
      #        hs.config({ num_workspaces = ${toString num_workspaces} })

      #        hl.bind("${mod} + G", hs.dsp.grab_rogue_windows())
      #        hl.bind("${mod} + mouse_down", hs.dsp.focus({ workspace = "r-1" }))
      #        hl.bind("${mod} + mouse_up", hs.dsp.focus({ workspace = "r+1" }))

      #        for i = 1, ${toString num_workspaces} do
      #          local key = "code:1" .. tostring(i - 1)
      #          hl.bind("${mod} + " .. key, hs.dsp.focus({ workspace = i }))
      #          hl.bind("${mod} + SHIFT + " .. key, hs.dsp.window.move({ workspace = i, follow = false }))
      #        end
      #        hl.bind("SUPER + " .. "d", hs.dsp.workspace.swap_monitors({ monitor1 = "current", monitor2 = "+1" }))

      #      '';
      #    };
      #};
    };

}
