_: {
  nix = {
    extraOptions = "experimental-features = nix-command flakes";

    gc = {
      # Perform garbage collection weekly to maintain low disk usage
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    settings = {
      # Optimize storage
      # You can also manually optimize the store via:
      #    nix-store --optimise
      # Refer to the following link for more details:
      # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
      auto-optimise-store = true;

      # Names of users or usergroups that have additional rights when connecting to the nix daemon, such as the
      # ability to specify additional binary caches, or to import unsigned NARs.
      trusted-users = [
        "root" # specific username
        "@wheel" # anyone within that group
      ];
    };
  };
}
