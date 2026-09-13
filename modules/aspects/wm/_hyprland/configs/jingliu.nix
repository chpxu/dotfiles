#lib: {
#  settings = {
#    monitor = [
#      "eDP-1, preferred, 0x0, 1"
#      "desc:Dell Inc. DELL P2425HE 62Y6474, preferred, -1080x0,1,  transform, 1"
#      "desc:Dell Inc. DELL P2425HE J9P9614, preferred, 2560x0,  1"
#    ];
#  };
#}

{ lib }: {
  settingsLua =
    let
      lua = lib.generators.mkLuaInline;
    in
    {
      monitor = [
        { _args = [ (lua ''{ output = "", mode = "preferred", scale = 1 }'') ]; }
      ];
      gesture = [
        # 3-finger horizontal swipe -> switch workspace
        { _args = [ (lua ''{ fingers = 3, direction = "horizontal", action = "workspace" }'') ]; }

        {
          _args = [
            (lua ''{ fingers = 3, direction = "up", mods = "SUPER", scale = 1.5, action = "fullscreen" }'')
          ];
        }
        {
          _args = [
            (lua ''{ fingers = 4, direction = "down", action = "special", workspace_name = "magic" }'')
          ];
        }
      ];
    };
}
