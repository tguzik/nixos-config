# Docs & reference:
# https://wiki.nixos.org/wiki/Sudo
#
{ ... }:
let
  swBin = "/run/current-system/sw/bin";
  wrappersBin = "/run/wrappers/bin";
in
{
  security.sudo = {
    enable = true;
    extraRules = [
      {
        groups = [ "wheel" ];
        commands = [
          {
            command = "${swBin}/systemctl";
            options = [ "NOPASSWD" ];
          }
          {
            command = "${wrappersBin}/mount";
            options = [ "NOPASSWD" ];
          }
          {
            command = "${wrappersBin}/umount";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };
}
