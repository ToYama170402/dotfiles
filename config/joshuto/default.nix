{ config, ... }:
{
  home.file."joshuto" = {
    enable = true;
    source = ../joshuto;
    target = "${config.xdg.configHome}/joshuto";
    recursive = true;
  };

}
