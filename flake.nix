{
  description = "~. Nix all the things!";

  inputs = {
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus/v1.5.1";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    latest.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    home.url = "github:nix-community/home-manager/release-24.05";
    home.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    nvfetcher.url = "github:berberman/nvfetcher";
    nvfetcher.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = {
    self,
    utils,
    nixpkgs,
    latest,
    nur,
    home,
    agenix,
    nvfetcher,
    impermanence,
    ...
  } @ inputs: let
    pkgs = self.pkgs.x86_64-linux.nixpkgs;
    mkApp = utils.lib.mkApp;
    suites = import ./suites.nix {inherit utils;};
  in
    with suites.nixosModules;
      utils.lib.mkFlake {
        inherit self inputs;
        inherit (suites) nixosModules;

        supportedSystem = ["x86_64-linux"];
        channelsConfig.allowUnfree = true;

        hosts.NotYourLaptop.modules =
          suites.desktopModules
          ++ [
            ./hosts/nixos/NotYourLaptop
          ];

        sharedOverlays = [
          nur.overlay
          (import ./pkgs)
        ];

        hostDefaults.modules =
          [
            home.nixosModules.home-manager
            agenix.nixosModules.age
            impermanence.nixosModules.impermanence
          ]
          ++ suites.sharedModules;
      };

  nixConfig.extra-experimental-features = "nix-command flakes";
}
