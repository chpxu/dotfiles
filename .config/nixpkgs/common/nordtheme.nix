{ lib, ...}: 
with lib;
{
  options = {
    nordtheme = mkOption {
      type = types.attrs;
      default = {
        nord0 = "#2e3440"; # Polar Night: Darkest
        nord1 = "#3b4252";
        nord2 = "#434c5e";
        nord3 = "#4c566a"; # Polar Night: Lightest
        nord4 = "#d8dee9"; # Snow Storm: Darkest
        nord5 = "#e5e9f0";
        nord6 = "#eceff4"; # Snow Storm: lightest
        nord7 = "#8fbcbb"; # Frost: Turquoise
        nord8 = "#88c0d0"; # Frost: Light Blue 
        nord9 = "#81a1c1"; # Frost Blue;
        nord10 = "#5e81ac"; # Frost: darker blue/purple 
        nord11 = "#bf616a"; # Aurora: red
        nord12 = "#d08770"; # Aurora: orange
        nord13 = "#ebcb8b"; # Aurora: yellow
        nord14 = "#a3be8c"; # Aurora: green
        nord15 = "#b48ead"; # Aurora: pink
      };
    };
  }; 
  
}