# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
#
# Ideas for later:
# - [...]
#
{ pkgs, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Include individual components
    ./components/baseline

    # TODO: Convert system configuration into a flake, but do so in a different feature branch
    ./components/sops-secrets.nix
    ./components/openssh

    ./components/gnupg.nix
    ./components/flatpak.nix
    ./components/podman.nix
    ./components/sudo.nix

    # Other stuff

    # Include settings containing non-public data
    ./homestead/networks.nix
    ./homestead/cifs.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  boot = {
    # Bootloader.
    loader = {
      systemd-boot = {
        enable = true;

        # Limit the number of generations to keep
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };

    # Use latest kernel.
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking = {
    hostName = "hermes";

    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networkmanager.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;
  };

  services = {
    xserver = {
      # Enable the X11 windowing system.
      enable = true;

      # Configure keymap in X11
      xkb = {
        layout = "pl";
        variant = "";
      };
    };

    # Enable the GNOME Desktop Environment.
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable sound with pipewire.
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;
  };

  # Enable sound with pipewire.
  security.rtkit.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tguzik = {
    isNormalUser = true;
    description = "tguzik";
    extraGroups = [
      "cifs"
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      calibre
      devenv
      ffmpeg
      firefox
      gdb
      ghex
      gimp
      gnucash
      graphviz
      imagemagick
      jq
      jetbrains.idea
      keepassxc
      kopia-ui
      spotify
      thunderbird
      veracrypt
      vlc
      vscodium
      zed-editor
    ];
  };

  programs = {
    firefox.enable = true;

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # mtr.enable = true;
  };

  environment = {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      btop
      file
      gitFull
      go-task
      kopia
      mc
      nano
      netcat-gnu
      nix-diff
      nixfmt
      ripgrep
      tmux
      vim
      wget
    ];

    # System-level variables
    variables = {
      EDITOR = "vim";
    };

    # Session-specific variables
    sessionVariables = {
      BROWSER = "firefox";
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
