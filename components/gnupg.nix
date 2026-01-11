{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gnupg
    pinentry-curses
  ];

  programs = {
    # Use gpg-agent instead of ssh-agent
    ssh.startAgent = false;

    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
        pinentryPackage = pkgs.pinentry-curses;

        # Declarative version of /etc/gnupg/gpg-agent.conf
        settings = {
          allow-loopback-pinentry = "";
          default-cache-ttl = 60;
          enable-ssh-support = "";
          max-cache-ttl = 120;
          ttyname = "$GPG_TTY";
        };
      };
    };
  };
}
