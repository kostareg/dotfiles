{
  pkgs,
  lib,
  ...
}: let
  # TODO: Use this as flake input, or find another proper way to lock this.
  fromGitHub = ref: repo: rev:
    pkgs.vimUtils.buildVimPlugin {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = builtins.fetchGit {
        url = "https://github.com/${repo}.git";
        ref = ref;
        rev = rev;
      };
    };
in {
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = builtins.readFile ./nvim.lua;

    plugins = with pkgs;
    with pkgs.vimPlugins; [
      dressing-nvim
      {
        plugin = catppuccin-nvim;
        config = "colorscheme catppuccin-mocha";
      }
      nvim-notify
      heirline-nvim
      nvim-web-devicons
      gitsigns-nvim
      mini-nvim
      which-key-nvim
      popup-nvim
      plenary-nvim
      telescope-nvim
      telescope-zoxide
      (fromGitHub "HEAD" "natecraddock/workspaces.nvim" "c8bd98990d322b107e58ff5373038b753a8ef66d")
      nvim-tree-lua
      vim-startify
      nvim-treesitter
      nvim-lspconfig
      lsp-zero-nvim
      nvim-navic
      direnv-vim
    ];
  };

  home.packages = with pkgs; [xclip];
}
