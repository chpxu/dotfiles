{
  den.aspects.flameshot = {
    homeManager = {
      services.flameshot = {
        enable = true;
        settings = {
          General = {

            # More settings may be found on the Flameshot Github

            # Save Path
            # savePath = "$XDG_SCREENSHOTS_DIR";
            # Tray
            disabledTrayIcon = true;
            # Greeting message
            showStartupLaunchMessage = false;
            # Default file extension for screenshots (.png by default)
            saveAsFileExtension = ".png";
            # Desktop notifications
            showDesktopNotification = true;
            # Notification for cancelled screenshot
            showAbortNotification = true;
            # Whether to show the info panel in the center in GUI mode
            showHelp = true;
            # Whether to show the left side button in GUI mode
            showSidePanelButton = true;
            # Whether to enable legacy (pre-xdg-desktop-portal) screenshotting on X11
            useX11LegacyScreenshot = true;
            # Whether to skip display selection prompt (X11-only)
            captureActiveMonitor = true;

            # Color Customization
            uiColor = "#740096";
            contrastUiColor = "#270032";
            drawColor = "#ff0000";

            # For Wayland (Install Grim seperately)
            # useGrimAdapter = true;
            # Stops warnings for using Grim
            # disabledGrimWarning = true;
          };
        };
      };

    };
  };
}
