{
  programs.bash = {
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
}
