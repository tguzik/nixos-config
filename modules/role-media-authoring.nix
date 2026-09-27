{
  flake_hasGui,
  flake_primaryUsername,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./baseline
  ];

  # These packages will be included only when the expression evaluates to `true`
  users.users.${flake_primaryUsername}.packages =
    with pkgs;
    lib.optionals flake_hasGui [
      audacity # Sound editor with graphical UI
      gimp # GNU Image Manipulation Program
      imagemagick # Software suite to create, edit, compose, or convert bitmap images
      inkscape # Vector graphics editor
      krita # Free and open source painting application
      pkgs.kdePackages.kdenlive # Free and open source video editor, based on MLT Framework and KDE Frameworks
      # davinci-resolve # UNFREE, requires discrete GPU # Professional video editing, color, effects and audio post-processing
    ];
}
