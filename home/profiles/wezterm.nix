{pkgs, ...}: {
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require 'wezterm'
      local config = wezterm.config_builder()

      config.font = wezterm.font 'PragmataPro Mono Liga'
      config.color_scheme = 'Catppuccin Mocha'

      return config
    '';
  };
}
