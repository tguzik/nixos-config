{ config, pkgs, ... }:
let
  access_group_name = config.users.groups.cifs.name;
in
{
  imports = [
    # Ensure sops setup is loaded:
    ./sops-secrets.nix
  ];

  # Package required for mount.cifs (can be skipped if domain name resolution is not needed):
  environment.systemPackages = with pkgs; [
    cifs-utils
  ];

  # Declare sops secret related to samba/cifs:
  sops.secrets."network/cifs/spinningrust-role-readonly" = { };
  sops.secrets."network/cifs/spinningrust-role-readwrite" = { };

  # Mount Samba/CIFS shares as a client
  fileSystems = {
    # https://wiki.nixos.org/wiki/Samba#CIFS_mount_configuration
    # Example from wiki:
    #
    # "/mnt/share" = {
    #   device = "//<IP_OR_HOST>/path/to/share";
    #   fsType = "cifs";
    #   options = let
    #     # this line prevents hanging on network split
    #     automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    #
    #   in ["${automount_opts},credentials=/etc/nixos/smb-secrets" "nofail"];
    # };
    #

    "/media/spinningrust" = {
      device = "//192.168.0.10/StorageVolume1";
      fsType = "cifs";
      options = [
        # Prevent hanging on network split:
        "noauto"
        "x-systemd.automount"
        "x-systemd.idle-timeout=60"
        "x-systemd.device-timeout=5s"
        "x-systemd.mount-timeout=5s"

        # Don't hold up the system startup if the network/nas is not available
        "nofail"

        # Access storage using credentials stored in sops:
        "credentials=${config.sops.secrets."network/cifs/spinningrust-role-readwrite".path}"

        # Restrict access only to users within the local group:
        "uid=0"
        "gid=${access_group_name}"
        "dir_mode=0770"
        "file_mode=0660"
        "forceuid"
        "forcegid"
      ];
    };
  };

  # Enable GVFS, so that network shares are browsable in GTK-based apps
  services.gvfs.enable = true;
}
