{
  config,
  flake_primaryUsername,
  lib,
  pkgs,
  ...
}:
let
  #
  # These packages will be included only when `config.nixpkgs.config.allowUnfree` is `true`
  unfree_gui_packages =
    with pkgs;
    lib.optionals config.nixpkgs.config.allowUnfree [
      spotify # Play music from the Spotify music service
    ];
in
{
  imports = [
    ./baseline
  ];

  users.users.${flake_primaryUsername}.packages =
    with pkgs;
    [
      calibre # Comprehensive e-book software
      ffmpeg # Complete, cross-platform solution to record, convert and stream audio and video
      vlc # Cross-platform media player and streaming server
    ]
    ++ unfree_gui_packages;
}
