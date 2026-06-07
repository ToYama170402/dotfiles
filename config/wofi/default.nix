{ config, ... }:
{
  home.file."wofi" = {
    enable = true;
    source = ../wofi;
    target = "${config.xdg.configHome}/wofi";
    recursive = true;
  };

}
