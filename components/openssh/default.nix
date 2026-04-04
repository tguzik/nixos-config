_: {
  # Default to basic configuration.
  # If the current machine has a server-like profile, it should import ./server.nix instead.
  imports = [ ./base.nix ];
}
