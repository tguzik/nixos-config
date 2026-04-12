{ pkgs, ... }:
{
  imports = [
    ./baseline
    ./individual/gnupg.nix
    ./individual/openssh.nix
    ./individual/sudo.nix
  ];

  environment.systemPackages = with pkgs; [
    pciutils # lspci; enumerate pci devices
    usbutils # lsusb; enumerate usb devices
    dmidecode # read detailed hardware information from bios/uefi
    cpufetch # neofetch-like simple yet fancy CPU architecture fetching tool
    acpi # Show battery status and other ACPI information
  ];
}
