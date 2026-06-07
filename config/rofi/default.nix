{ config, ... }:
{
  home.file."rofi" = {
    enable = true;
    source = ../rofi;
    target = "${config.xdg.configHome}/rofi";
    recursive = true;
  };

}
