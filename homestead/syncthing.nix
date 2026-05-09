# Docs & reference:
# https://wiki.nixos.org/wiki/Syncthing
{ config, flake_primaryUsername, ... }:
let
  # Declare the secret name as a variable, just to avoid typos
  syncthing_gui_password_secret_name = "syncthing/gui-password";
in
{
  imports = [
    # Ensure sops setup is loaded:
    ./sops-secrets.nix
  ];

  # Declare sops secret related to network data:
  sops.secrets."${syncthing_gui_password_secret_name}" = {
    owner = flake_primaryUsername;
  };

  services.syncthing = {
    # Enable system service for Syncthing, to make sure it 1) survives reboots, and 2) starts automatically
    enable = true;
    openDefaultPorts = true;

    user = flake_primaryUsername;
    dataDir = "/home/${flake_primaryUsername}/syncthing";
    guiPasswordFile = config.sops.secrets."${syncthing_gui_password_secret_name}".path;
    settings.gui.user = flake_primaryUsername;
  };
}
