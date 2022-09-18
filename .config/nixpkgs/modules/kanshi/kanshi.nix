{
  config,
  pkgs,
  ...
}: {
  services.kanshi = {
    enable = true;
    package = pkgs.kanshi;
    profiles = {
      laptopOnly = {
        outputs = [
          {
            criteria = "eDP-1";
            mode = "3840x2160@60Hz";
            position = "0,0";
            scale = 2.0;
          }
        ];
      };
      laptopPlusAOC1 = {
        outputs = [
          {
            criteria = "eDP-1";
            mode = "3840x2160@60Hz";
            position = "0,0";
            scale = 2.0;
          }
          {
            criteria = "DP-3";
            mode = "1920x1080@144Hz";
            position = "1920,0";
            scale = 1.0;
          }
        ];
      };
    };
  };
}
