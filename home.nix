{
  config,
  pkgs,
  inputs,
  ...
}:
let
  nixGL = "${pkgs.nixgl.auto.nixGLDefault}/bin/nixGL";
in
{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    bat
    blender
    btop
    discord
    discord-ptb
    fastfetch
    feh
    fzf
    handbrake
    inkscape
    iotop
    jq
    lazydocker
    lazygit
    losslesscut-bin
    mpv
    nethogs
    nil
    nixfmt
    nixgl.auto.nixGLDefault
    nmap
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    pandoc
    pavucontrol
    radeontop
    slack
    tree
    typst
    vim
    zathura
  ];

  programs = {
    alacritty = {
      enable = true;
      settings = {
        font = {
          size = 16.0;
          normal = {
            family = "HackGen35 Console";
            style = "Regular";
          };
          bold = {
            family = "HackGen35 Console";
            style = "Bold";
          };
        };

        colors = {
          primary = {
            background = "#272822";
            foreground = "#f8f8f2";
          };
          cursor = {
            text = "CellBackground";
            cursor = "CellForeground";
          };
          normal = {
            black = "#272822";
            red = "#f92672";
            green = "#a6e22e";
            yellow = "#f4bf75";
            blue = "#66d9ef";
            magenta = "#ae81ff";
            cyan = "#a1efe4";
            white = "#f8f8f2";
          };
          bright = {
            black = "#75715e";
            red = "#f92672";
            green = "#a6e22e";
            yellow = "#f4bf75";
            blue = "#66d9ef";
            magenta = "#ae81ff";
            cyan = "#a1efe4";
            white = "#f9f8f5";
          };
        };
      };
    };

    bash = {
      enable = true;
      shellAliases = {
        ls = "ls --color=auto";
        ll = "ls -l";
        la = "ls -a";
        grep = "grep --color=auto";
        feh = "feh --scale-down --auto-zoom";
      };
      initExtra = "
      function parse_git_branch {
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'

      }
      PS1='\\[\\033[01;32m\\]\\u@\\[\\033[01;34m\\]\\h \\[\\033[01;33m\\]\\w\\[\\033[00m\\]$(parse_git_branch)\\n\\$ '
    ";
    };

    direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    git = {
      enable = true;
      settings.user = {
        name = "toyama170402";
        email = "toyamasoujinng@gmail.com";
      };
    };

    nixvim = {
      enable = true;
      defaultEditor = true;

      opts = {
        nu = true;
        softtabstop = 2;
        shiftwidth = 2;
        expandtab = true;
        smartindent = true;
        termguicolors = true;
        langmenu = "en_US.UTF-8";
        clipboard = "unnamedplus";
      };

      keymaps =
        let
          options = {
            noremap = true;
            silent = true;
          };
        in
        [
          {
            mode = "i";
            key = "jj";
            action = "<ESC>";
            inherit options;
          }
          {
            mode = [
              "n"
              "v"
            ];
            key = "j";
            action = "gj";
            inherit options;
          }
          {
            mode = [
              "n"
              "v"
            ];
            key = "k";
            action = "gk";
            inherit options;
          }
        ];

      colorschemes.gruvbox-material-nvim.enable = true;

      plugins = { };

      extraPlugins = [
        (pkgs.vimUtils.buildVimPlugin {
          name = "fcitx.nvim";
          version = "master";
          src = pkgs.fetchFromGitHub {
            owner = "h-hg";
            repo = "fcitx.nvim";
            rev = "HEAD";
            hash = "sha256-0cxLjkg9rFtl4ISeiRlI14tDMezHQSiZIdchA2x2Yes=";
          };
        })
      ];
    };

    # neovim = {
    #   viAlias = true;
    #   vimAlias = true;
    #   vimdiffAlias = true;
    #   initLua = ''
    #     vim.cmd("language message en_US.UTF-8")

    #     -- vscode only
    #     --if vim.g.vscode then
    #     --end

    #     -- neovim only
    #     if not vim.g.vscode then
    #       -- only Neovim
    #       vim.cmd("syntax enable")
    #       vim.opt.number = true
    #     end
    # };

    zsh = {
      enable = true;
      shellAliases = {
        feh = "feh --scale-down --auto-zoom";
        dps = ''docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Status}}"'';
        l = "ls";
        la = "ls -a";
        ll = "ls -l";
        lg = "lazygit";
      };
      defaultKeymap = "viins";
      oh-my-zsh = {
        enable = true;
        theme = "dst";
        plugins = [
          "git"
        ];
      };
      autosuggestion = {
        enable = true;
      };
      syntaxHighlighting = {
        enable = true;
      };
      initContent = ''
        # viモードでカーソルの形を変更する
        # インサートモード: 縦棒 |
        # ノーマルモード: 四角いブロック █
        function zle-keymap-select () {
          case $KEYMAP in
            vicmd) echo -ne '\e[1 q';; # ノーマルモード
            viins) echo -ne '\e[5 q';; # インサートモード
            *) echo -ne '\e[5 q';;
          esac
        }
        zle -N zle-keymap-select
        zle-line-init() {
            zle -K viins # 初期モードをインサートに設定
            echo -ne "\e[5 q"
        }
        zle -N zle-line-init

        source <(fzf --zsh)
      '';
    };
  };

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
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    "hypr" = {
      enable = true;
      source = ./hypr;
      target = builtins.getEnv "HOME" + "/.config/hypr";
      recursive = true;
    };
    "i3" = {
      enable = true;
      source = ./i3;
      target = builtins.getEnv "HOME" + "/.config/i3";
      recursive = true;
    };
    "i3status" = {
      enable = true;
      source = ./i3status;
      target = builtins.getEnv "HOME" + "/.config/i3status";
      recursive = true;
    };
    "joshuto" = {
      enable = true;
      source = ./joshuto;
      target = builtins.getEnv "HOME" + "/.config/joshuto";
      recursive = true;
    };
    "rofi" = {
      enable = true;
      source = ./rofi;
      target = builtins.getEnv "HOME" + "/.config/rofi";
      recursive = true;
    };
    "waybar" = {
      enable = true;
      source = ./waybar;
      target = builtins.getEnv "HOME" + "/.config/waybar";
      recursive = true;
    };
    "wofi" = {
      enable = true;
      source = ./wofi;
      target = builtins.getEnv "HOME" + "/.config/wofi";
      recursive = true;
    };
    "zathura" = {
      enable = true;
      source = ./zathura;
      target = builtins.getEnv "HOME" + "/.config/zathura";
      recursive = true;
    };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/toyama/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    XDG_DATA_DIRS = "$HOME/.local/share/applications:$HOME/.nix-profile/share/applications:/usr/local/share:/usr/share:$XDG_DATA_DIRS";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    QT_QPA_PLATFORM = "wayland";
  };

  # Let Home Manager install and manage itself.
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
