{
  config,
  pkgs,
  ...
}: let
  drv = pkgs.stdenv.mkDerivation {
    pname = "pragmatapro";
    version = "0.830";
    src = ./PragmataPro-Regular0.830;

    phases = ["installPhase"];

    installPhase = ''
      install -m444 -Dt $out/share/fonts/truetype $src/*.ttf
    '';
  };
in {
  fonts.fontconfig.enable = true;

  home.packages = [
    drv
  ];
}
