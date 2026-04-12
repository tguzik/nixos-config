{ pkgs, ... }:
{
  imports = [
    ./baseline
  ];

  environment.systemPackages = with pkgs; [
    gnucash # Free software for double entry accounting
    hunspell # Spell checker
    hunspellDicts.en_GB-large # Hunspell dictionary for English (United Kingdom) Large from Wordlist
    hunspellDicts.en_US-large # Hunspell dictionary for English (United States) Large from Wordlist
    hunspellDicts.pl_PL # Hunspell dictionary for Polish (Poland) from LibreOffice
    keepassxc # Offline password manager with many features
    libreoffice # Comprehensive, professional-quality productivity suite, a variant of openoffice.org
    thunderbird # Full-featured e-mail client
    veracrypt # Free Open-Source filesystem on-the-fly encryption
  ];
}
