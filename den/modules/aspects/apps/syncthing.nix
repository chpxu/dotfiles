{
  den.aspects.syncthing = {
    homeManager = {
      services.syncthing = {
        enable = true;
        guiAddress = "127.0.0.1:8384";
        settings = {
          gui = {
            theme = "black";
          };
          options = {
            urAccepted = -1;
          };
        };
        overrideDevices = false;
        overrideFolders = false;
        tray = {
          enable = false;
        };
      };
    };
  };
}
