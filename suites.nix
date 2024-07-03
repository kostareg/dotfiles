{utils}: let
  nixosModules = utils.lib.exportModules [];
  sharedModules = with nixosModules; [
    {
      users.users.root.password = "root";

      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
    }
  ];
  desktopModules = with nixosModules; [
    ({
      pkgs,
      lib,
      config,
      ...
    }: {
      home-manager.users.areg = import ./home/users/areg.nix;
    })
  ];
in {
  inherit nixosModules sharedModules desktopModules;
}
