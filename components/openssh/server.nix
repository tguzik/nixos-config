{ lib, ... }:
{
  imports = [ ./default.nix ];

  # Enable root login for remote deployments:
  services.openssh.settings.PermitRootLogin = lib.mkForce "prohibit-password";
}
