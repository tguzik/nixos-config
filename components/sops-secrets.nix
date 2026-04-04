# Docs & reference:
# https://github.com/Mic92/sops-nix
# https://github.com/Mic92/sops-nix?tab=readme-ov-file#usage-example
# https://github.com/getsops/sops
# https://github.com/FiloSottile/age
# https://github.com/Mic92/ssh-to-age
#
# TODO: Convert system configuration into a flake, but do so in a different feature branch
#
{ pkgs, ... }:
let
  machineSshKey = "/etc/ssh/ssh_host_ed25519_key";
in
{
  imports = [
    "${
      builtins.fetchTarball {
        url = "https://github.com/Mic92/sops-nix/archive/5e8fae80726b66e9fec023d21cd3b3e638597aa9.tar.gz";
        sha256 = "0qzxgkr8bi055jh8sdf4fn0gkn0y2z3598x6nr8l3ns8zh2k4a3a";
      }
    }/modules/sops"

    # We need to enable OpenSSH to generate the host machine key, which will be used to
    # generate age key for that machine to be able to decrypt secrets
    ./openssh
  ];

  # There's also pkgs.ssh-to-age to generate an age key based on machine's SSH key,
  # however it is not needed at runtime
  environment.systemPackages = with pkgs; [
    age
    sops
  ];

  sops = {
    # This will add secrets.yml to the nix store
    # You can avoid this by adding a string to the full path instead, i.e.
    #sops.defaultSopsFile = "/root/.sops/secrets/example.yaml";
    defaultSopsFile = ../secrets-sops/main-keystore.yaml;

    age = {
      # This will automatically import SSH keys as age keys:
      sshKeyPaths = [ machineSshKey ];

      # This is using an age key that is expected to already be in the filesystem:
      #keyFile = "/var/lib/sops-nix/key.txt";

      # This will generate a new key if the key specified above does not exist:
      #generateKey = true;
    };

    # Example on how to declare which keys in the SOPS file should be imported as FILES in `/run/secrets/...` at
    # the SYSTEM RUNTIME. These values will not be available during configuration evaluation time (nixos-rebuild), so
    # plan accordingly.
    secrets = {
      sampleValueAtRoot = { };
    };
  };
}
