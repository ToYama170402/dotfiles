{ config, ... }:
{
  home.file."waybar" = {
    enable = true;
    source = ../waybar;
    target = "${config.xdg.configHome}/waybar";
    recursive = true;
  };

}
