{ config, ... }:
{
  home.file."zathura" = {
    enable = true;
    source = ../zathura;
    target = "${config.xdg.configHome}/zathura";
    recursive = true;
  };
}
