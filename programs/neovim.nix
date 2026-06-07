{ pkgs, inputs, ... }:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

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

    extraConfigLua = ''
      vim.cmd("language message en_US.UTF-8")
      -- vscode only
      --if vim.g.vscode then
      --end
      -- neovim only
      if not vim.g.vscode then
        -- only Neovim
        vim.cmd("syntax enable")
        vim.opt.number = true
      end
    '';

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

}
