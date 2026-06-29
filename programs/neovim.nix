{ pkgs, inputs, ... }:
{
  nixpkgs.config.allowUnfree = true;

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
        require("hlchunk").setup({
          blank = {
            enable = true,
          },
          chunk = {
            enable = true,       
          },
          indent = {
            enable = true,
          },
        })
      end

    '';

    plugins = {
      auto-save.enable = true;
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "async-path"; }
            { name = "buffer"; }
          ];
        };
        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })";
          "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' })";
        };
      };
      comment.enable = true;
      lsp = {
        enable = true;
        servers = {
          lua_ls.enable = true;
          marksman.enable = true;
          nixd.enable = true;
          tynymist.enable = true;
        };
      };
      nvim-autopairs.enable = true;
      treesitter = {
        enable = true;
        highlight.enable = true;
        indent.enable = true;
        folding.enable = true;
      };
    };

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
      (pkgs.vimUtils.buildVimPlugin {
        name = "nvim-markdown";
        version = "master";
        src = pkgs.fetchFromGitHub {
          owner = "ixru";
          repo = "nvim-markdown";
          rev = "HEAD";
          hash = "sha256-wjYTO9WqdDEbH4L3dsHqOoeQf0y/Uo6WX94w/D4EuGU=";
        };
      })
      pkgs.vimPlugins.hlchunk-nvim
    ];
  };
}
