{
  pkgs,
  ...
}:
let
  nixGL = "${pkgs.nixgl.auto.nixGLDefault}/bin/nixGL";
in
{
  imports = [
    ./programs
    ./packages.nix
    ./config
  ];
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";
  home.stateVersion = "25.11"; # Please read the comment before changing.

  services = {
    flameshot = {
      enable = true;
      settings = {
        General = {
          useGrimAdapter = true;
          disabledTrayIcon = false;
          showDesktopNotification = false;
          showAbortNotification = false;
          showStartupLaunchMessage = false;
        };
      };
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    XDG_DATA_DIRS = "$HOME/.local/share/applications:$HOME/.nix-profile/share/applications:/usr/local/share:/usr/share:$XDG_DATA_DIRS";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    QT_QPA_PLATFORM = "wayland";
  };

  programs.home-manager.enable = true;

  xdg.desktopEntries = {
    Alacritty = {
      name = "Alacritty (NixGL)";
      exec = "${nixGL} ${pkgs.alacritty}/bin/alacritty";
      icon = "alacritty";
      terminal = false;
      categories = [
        "System"
        "TerminalEmulator"
      ];
    };

    inkscape = {
      name = "Inkscape (NixGL)";
      exec = "${nixGL} ${pkgs.inkscape}/bin/inkscape";
      icon = "inkscape";
      categories = [
        "Graphics"
        "VectorGraphics"
      ];
    };

    blender = {
      name = "Blender (NixGL)";
      exec = "${nixGL} ${pkgs.blender}/bin/blender";
      icon = "blender";
      categories = [
        "Graphics"
        "3DGraphics"
      ];
    };

    krita = {
      name = "Krita (NixGL)";
      exec = "${nixGL} ${pkgs.krita}/bin/krita";
      icon = "krita";
      categories = [
        "Graphics"
        "RasterGraphics"
      ];
    };
  };
}
