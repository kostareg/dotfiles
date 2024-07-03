{
  lib,
  pkgs,
  config,
  options,
  ...
}:
with lib;
with pkgs; let
  x = "x";
in {
  imports = [
    ../profiles/bash.nix
    ../profiles/emacs.nix
    ../profiles/eza.nix
    ../profiles/fonts
    ../profiles/git.nix
    ../profiles/gpg.nix
    ../profiles/latex.nix
    ../profiles/nvim.nix
    ../profiles/teams.nix
    ../profiles/tokei.nix
    ../profiles/wezterm.nix
    ../profiles/zathura.nix
    ../profiles/zoxide.nix
  ];

  # TODO: separate, or make a dev profile. It's used for clangd.
  # Or, put it in project dev environments.
  home.packages = with pkgs; [clang-tools nh];

  home.stateVersion = "23.05";
}
