{ pkgs, ... }:
{
  imports = [
    ./baseline
  ];

  environment.systemPackages = with pkgs; [
    audacity # Sound editor with graphical UI
    gimp # GNU Image Manipulation Program
  ];
}
