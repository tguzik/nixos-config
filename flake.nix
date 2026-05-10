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
        "asus-expertbook-p5" = nixpkgs.lib.nixosSystem {
          specialArgs =
            let
              flake_hasGui = true;
              flake_primaryUsername = "tguzik";
              system = "x86_64-linux";
            in
            {
              inherit flakeInputs;
              inherit flake_hasGui;
              inherit flake_primaryUsername;
              pkgs-unstable = import nixpkgs-unstable {
                inherit system;
              };
            };

          modules = [
            ./hosts/asus-expertbook-p5/configuration.nix
            sops-nix.nixosModules.sops
          ];
        };
        "ms-r1" = nixpkgs.lib.nixosSystem {
          specialArgs =
            let
              flake_hasGui = true;
              flake_primaryUsername = "tguzik";
              system = "aarch64-linux";
            in
            {
              inherit flakeInputs;
              inherit flake_hasGui;
              inherit flake_primaryUsername;
              pkgs-unstable = import nixpkgs-unstable {
                inherit system;
              };
            };

          modules = [
            ./hosts/ms-r1/configuration.nix
            sops-nix.nixosModules.sops
          ];
        };
        "nuc-frost-canyon" = nixpkgs.lib.nixosSystem {
          specialArgs =
            let
              flake_hasGui = true;
              flake_primaryUsername = "tv";
            in
            {
              inherit flakeInputs;
              inherit flake_hasGui;
              inherit flake_primaryUsername;
            };

          modules = [
            ./hosts/nuc-frost-canyon/configuration.nix
            sops-nix.nixosModules.sops
          ];
        };
      };
    };
}
