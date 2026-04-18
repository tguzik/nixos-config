{ pkgs, pkgs-unstable, ... }:
# pkgs-unstable is a non-standard input added in flake.nix
{
  imports = [
    ./baseline
  ];

  environment.systemPackages = with pkgs; [
    opencode # https://github.com/anomalyco/opencode # AI coding agent built for the terminal # [$] ollama launch opencode
    oterm # https://github.com/ggozad/oterm # Text-based terminal client for Ollama
  ];

  services.ollama = {
    enable = true;
    openFirewall = false;

    # From option description:
    #
    # > The ollama package to use. Different packages use different hardware acceleration.
    # >
    # > * ollama: default behavior; usually equivalent to ollama-cpu
    # >   * if nixpkgs.config.rocmSupport is enabled, is equivalent to ollama-rocm
    # >   * if nixpkgs.config.cudaSupport is enabled, is equivalent to ollama-cuda
    # >   * otherwise defaults to ollama-cpu
    # > * ollama-cpu: disable GPU; only use CPU
    # > * ollama-rocm: supported by most modern AMD GPUs
    # >   * may require overriding gpu type with services.ollama.rocmOverrideGfx if rocm doesn’t detect your AMD gpu
    # > * ollama-cuda: supported by most modern NVIDIA GPUs
    # > * ollama-vulkan: supported by most GPUs
    #
    # NOTE: This one is imported from unstable nixpkgs!
    # The main reason is that the ollama 0.12 (nixos-25.11 @ 2026-04-12) is too old to pull new models.
    package = pkgs-unstable.ollama;

    # From option description:
    #
    # > Download these models using ollama pull as soon as ollama.service has started.
    # > This creates a systemd unit ollama-model-loader.service. Use services.ollama.syncModels to automatically
    # > remove any models not currently declared here.
    # > Search for models of your choice from: https://ollama.com/library
    #
    loadModels = [
      # Just the basics that can run on relatively common hardware and do not take too much disk space. Pulling tens
      # of gigabytes on rebuild isn't the bestest of experiences.
      "gemma4:e4b"
      "qwen3.5:9b"
    ];

    # From option description:
    #
    # > Set arbitrary environment variables for the ollama service.
    # > Be aware that these are only seen by the ollama server (systemd service), not normal invocations like
    # > ollama run. Since ollama run is mostly a shell around the ollama server, this is usually sufficient.
    #
    environmentVariables = {
      SOME_RANDOM_ENVIRONMENT_VARIABLE = "lol";
    };
  };
}
