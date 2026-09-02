{ config, ... }:
{
  home.file."nix" = {
    enable = true;
    source = ../nix;
    target = "${config.xdg.configHome}/nix";
    recursive = true;
  };
}
