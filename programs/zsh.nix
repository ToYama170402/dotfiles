{
  programs.zsh = {
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
}
