{ lib, ... }:
{
  services.openssh = {
    # Enable OpenSSH daemon:
    enable = true;
    settings = {
      # Disable root login by default:
      PermitRootLogin = lib.mkDefault "no";
      # Disable password login by default:
      PasswordAuthentication = lib.mkDefault false;
    };
  };
}
