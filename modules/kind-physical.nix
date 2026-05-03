{ pkgs, ... }:
{
  imports = [
    ./baseline
    ./individual/gnupg.nix
    ./individual/openssh.nix
    ./individual/sudo.nix
  ];

  environment.systemPackages = with pkgs; [
    acpi # Show battery status and other ACPI information
    dmidecode # read detailed hardware information from bios/uefi
    fastfetch # https://github.com/fastfetch-cli/fastfetch # Feature-rich neofetch like system information tool
    lshw # https://ezix.org/project/wiki/HardwareLiSter # Provide detailed information on the hardware configuration of the machine
    pciutils # lspci; enumerate pci devices
    usbutils # lsusb; enumerate usb devices
  ];
}
