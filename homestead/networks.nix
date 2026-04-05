{ config, ... }:
let
  # Expected sops secret layout:
  #
  # network:
  #    wireless: |
  #      WIFI_01_SSID=<...>
  #      WIFI_01_PSK=<...>
  #      WIFI_02_SSID=<...>
  #      WIFI_02_PSK=<...>
  #
  network_sops_secret_name = "network/wireless";
  network_placeholder_names = [
    # Names must match entries in sops file
    "WIFI_01"
    "WIFI_02"
    "WIFI_03"
  ];
in
{
  imports = [
    # Ensure sops setup is loaded:
    ./sops-secrets.nix
  ];

  # Declare sops secret related to network data:
  sops.secrets."${network_sops_secret_name}" = { };

  networking.networkmanager = {
    enable = true;

    ensureProfiles = {
      # Import contents of sops secret as .env file:
      environmentFiles = [
        config.sops.secrets."${network_sops_secret_name}".path
      ];

      # Declare profiles with names from the network_placeholder_names variable and using .env substitutions
      # for SSID/PSK from sops secrets:
      profiles = builtins.listToAttrs (
        map (
          placeholder-item-name:
          let
            ssid_variable = "\$${placeholder-item-name}_SSID";
            psk_variable = "\$${placeholder-item-name}_PSK";
          in
          {
            name = placeholder-item-name;
            value = {
              connection = {
                id = ssid_variable;
                type = "wifi";
              };
              ipv4 = {
                dns-search = "";
                method = "auto";
              };
              ipv6 = {
                dns-search = "";
                method = "auto";
              };
              wifi = {
                mode = "infrastructure";
                ssid = ssid_variable;
              };
              wifi-security = {
                auth-alg = "open";
                key-mgmt = "wpa-psk";
                psk = psk_variable;
              };
            };
          }
        ) network_placeholder_names
      );
    };
  };
}
