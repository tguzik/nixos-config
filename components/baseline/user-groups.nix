_: {
  # Declare additional, non-standard groups
  users.groups = {
    cifs = {
      # Users with this group will have access to CIFS/Samba shares
      name = "cifs"; # Technically we don't have to redeclare the name, this is just for the sake of completeness.
    };
  };
}
