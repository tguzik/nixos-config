_: {
  networking = {
    # Networks themselves are configured via secrets, not here
    networkmanager.enable = true;
    firewall.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
  };
}
