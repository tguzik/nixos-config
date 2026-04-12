_: {
  imports = [
    ./nix-baseline.nix

    ./clean-tmp-on-boot.nix
    ./locale.nix
    ./networking.nix
    ./packages.nix
    ./user-groups.nix
  ];
}
