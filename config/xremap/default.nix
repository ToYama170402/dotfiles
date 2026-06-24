{ config, ... }:
{
  home.file."xremap" = {
    enable = true;
    source = ../xremap;
    target = "${config.xdg.configHome}/xremap";
    recursive = true;
  };
}
