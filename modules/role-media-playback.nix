{
  config,
  flake_hasGui,
  flake_primaryUsername,
  lib,
  pkgs,
  ...
}:
let
  # These packages will be included only when the expression evaluates to `true`
  unfree_gui_packages =
    with pkgs;
    lib.optionals (flake_hasGui && config.nixpkgs.config.allowUnfree) [
      spotify # Play music from the Spotify music service
    ];
in
{
  imports = [
    ./baseline
  ];

  users.users.${flake_primaryUsername}.packages =
    with pkgs;
    lib.optionals flake_hasGui [
      calibre # Comprehensive e-book software
      ffmpeg # Complete, cross-platform solution to record, convert and stream audio and video
      vlc # Cross-platform media player and streaming server
    ]
    ++ unfree_gui_packages;
}
