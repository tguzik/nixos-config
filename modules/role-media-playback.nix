{ pkgs, ... }:
let
  unfree_gui_packages = with pkgs; [
    spotify # Play music from the Spotify music service
  ];
in
{
  imports = [
    ./baseline
  ];

  environment.systemPackages =
    with pkgs;
    [
      calibre # Comprehensive e-book software
      ffmpeg # Complete, cross-platform solution to record, convert and stream audio and video
      vlc # Cross-platform media player and streaming server
    ]
    ++ unfree_gui_packages;
}
