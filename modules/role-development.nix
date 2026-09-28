# TODO:
# - Add a configuration switch to enable/disable GUI programs - move inclusion of IntelliJ, vscodium & friends when enabled
#
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
  gui_packages =
    with pkgs;
    lib.optionals flake_hasGui [
      vscodium # Open source source code editor developed by Microsoft - VS Code without MS branding/telemetry/licensing.
      ghex # Hex editor for GNOME desktop environment
    ];
  unfree_gui_packages =
    with pkgs;
    lib.optionals (flake_hasGui && config.nixpkgs.config.allowUnfree) [
      jetbrains.idea # Java, Kotlin, Groovy and Scala IDE from Jetbrains
    ];
in
{
  imports = [
    ./baseline
    ./individual/gnupg.nix
    ./individual/flatpak.nix
    ./individual/podman.nix
  ];

  users.users.${flake_primaryUsername}.packages =
    with pkgs;
    [
      devenv # https://github.com/cachix/devenv # Fast, Declarative, Reproducible, and Composable Developer Environments using Nix
      direnv # https://direnv.net/ # Shell extension that manages your environment
      gdb # GNU Project debugger
      hextazy # https://github.com/0xfalafel/hextazy # TUI hexeditor in Rust with colored bytes
      ltrace # https://gitlab.com/cespedes/ltrace # Library call tracer
      strace # https://github.com/strace/strace # System call tracer for Linux
    ]
    ++ gui_packages
    ++ unfree_gui_packages;
}
