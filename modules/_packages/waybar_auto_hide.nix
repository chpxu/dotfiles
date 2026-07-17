{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "waybar_auto_hide";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "Zephirus2";
    repo = "waybar_auto_hide";
    tag = finalAttrs.version;
    hash = "sha256-Bp+wUZpu6k7j9ZhfZFDHw/dkreSoS7uWa6H9cbdCz4o=";
  };

  cargoHash = "sha256-mUY36hnyU/qjHRLqRwfVLl6hAGIy92Sg6s1XB56Hvf8=";

  meta = {
    description = "A lightweight utility that automatically shows/hides Waybar in Hyprland based on cursor position and window state.";
    homepage = "https://github.com/Zephirus2/waybar_auto_hide";
    license = lib.licenses.gpl3;
    maintainers = [ ];
  };
})
