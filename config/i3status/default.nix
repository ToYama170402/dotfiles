{ config, ... }:
{
  home.file."i3status" = {
    enable = true;
    source = ../i3status;
    target = "${config.xdg.configHome}/i3status";
    recursive = true;
  };

}
