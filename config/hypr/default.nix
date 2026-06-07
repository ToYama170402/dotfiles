{ config, ... }:
{
  home.file."hypr" = {
    enable = true;
    source = ../hypr;
    target = "${config.xdg.configHome}/hypr";
    recursive = true;
  };
}
