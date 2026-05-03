{ pkgs, ... }:
{
  imports = [
    ./baseline
  ];

  environment.systemPackages = with pkgs; [
    audacity # Sound editor with graphical UI
    gimp # GNU Image Manipulation Program
    inkscape # Vector graphics editor
    krita # Free and open source painting application
    # davinci-resolve # UNFREE, requires discrete GPU # Professional video editing, color, effects and audio post-processing
  ];
}
