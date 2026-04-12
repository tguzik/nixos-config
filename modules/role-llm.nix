{ pkgs-unstable, ... }:
# pkgs-unstable is a non-standard input added in flake.nix
{
  imports = [
    ./baseline
  ];

  environment.systemPackages = with pkgs-unstable; [
    #
    # NOTE: These are imported from unstable nixpkgs!
    # The main reason is that the ollama 0.12 (nixos-25.11 @ 2026-04-12) is too old to pull new models.
    #
    ollama # Get up and running with large language models locally
    ollama-cpu
    ollama-vulkan
    oterm # Text-based terminal client for Ollama
  ];
}
