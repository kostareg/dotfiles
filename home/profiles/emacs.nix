{pkgs, ...}: {
  programs.emacs = {
    enable = true;
    extraConfig = ''
      (set-frame-font "Pragmata Pro Mono Liga 12" nil t)
    '';
    extraPackages = epkgs: [];
  };

  services.emacs = {
    enable = true;
    startWithUserSession = "graphical";
    client.enable = true;
  };

  home.packages = with pkgs; [ispell];
}
