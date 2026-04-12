{
  description = "Flake with system configurations.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    flakeInputs@{
      nixpkgs,
      nixpkgs-unstable,
      sops-nix,
      ...
    }:
    {
      nixosConfigurations = {
        hermes = nixpkgs.lib.nixosSystem {
          specialArgs =
            let
              system = "x86_64-linux";
            in
            {
              inherit flakeInputs;
              pkgs-unstable = import nixpkgs-unstable {
                inherit system;
              };
            };

          modules = [
            ./hosts/hermes/configuration.nix
            sops-nix.nixosModules.sops
          ];
        };
      };
    };
}
