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
    fastfetch # https://github.com/fastfetch-cli/fastfetch # Feature-rich neofetch like system information tool
    acpi # Show battery status and other ACPI information
  ];
}
