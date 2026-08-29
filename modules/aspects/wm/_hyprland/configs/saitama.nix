{ lib }: {
  settingsLua =
    let
      lua = lib.generators.mkLuaInline;
    in
    {
      monitor = [
        { _args = [ (lua ''{ output = "", mode = "preferred", scale = 1 }'') ]; }
        {
          _args = [
            (lua ''
              {
                    output = "DP-1",
                    mode = "2560x1440@240.00",
                    position = "0x0",
                    scale = 1,
                    transform = 0,
                    bitdepth = 10,
                    vrr = 3
                  }'')
          ];
        }
        {
          _args = [
            (lua ''
              {
                    output = "HDMI-A-2",
                    mode = "1920x1080@144.00",
                    position = "-1080x0",
                    scale = 1,
                    transform = 1
                  }'')
          ];
        }
      ];
    };
}
