{
  flake_hasGui,
  flake_primaryUsername,
  lib,
  pkgs,
  ...
}:
let
  # These packages will be included only when the expression evaluates to `true`
  gui_packages =
    with pkgs;
    lib.optionals flake_hasGui [
      gnucash # Free software for double entry accounting
      kdePackages.kalk # https://invent.kde.org/utilities/kalk # Kalk is a powerful cross-platform calculator app
      keepassxc # Offline password manager with many features
      libreoffice # Comprehensive, professional-quality productivity suite, a variant of openoffice.org
      thunderbird # Full-featured e-mail client
    ];
in
{
  imports = [
    ./baseline
  ];

  users.users.${flake_primaryUsername}.packages =
    with pkgs;
    [
      hunspell # Spell checker
      hunspellDicts.en_GB-large # Hunspell dictionary for English (United Kingdom) Large from Wordlist
      hunspellDicts.en_US-large # Hunspell dictionary for English (United States) Large from Wordlist
      hunspellDicts.pl_PL # Hunspell dictionary for Polish (Poland) from LibreOffice
      veracrypt # Free Open-Source filesystem on-the-fly encryption
    ]
    ++ gui_packages;
}
