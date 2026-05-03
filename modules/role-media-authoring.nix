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
      inkscape # Vector graphics editor
      krita # Free and open source painting application
      # davinci-resolve # UNFREE, requires discrete GPU # Professional video editing, color, effects and audio post-processing
    ];
}
