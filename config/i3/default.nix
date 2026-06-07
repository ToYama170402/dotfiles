{ config, ... }:
{
  home.file."i3" = {
    enable = true;
    source = ../i3;
    target = "${config.xdg.configHome}/i3";
    recursive = true;
  };

}
