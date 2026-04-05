{
  description = "Flake with system configurations.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, sops-nix, ... }@inputs_to_outputs:
    {
      nixosConfigurations = {
        hermes = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/hermes/configuration.nix
            sops-nix.nixosModules.sops
          ];
          specialArgs = { inherit inputs_to_outputs; };
        };
      };
    };
}
