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
      zed-editor # https://github.com/zed-industries/zed # High-performance, multiplayer code editor from the creators of Atom and Tree-sitter
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
      gdb # GNU Project debugger
      hextazy # https://github.com/0xfalafel/hextazy # TUI hexeditor in Rust with colored bytes
      imagemagick # Software suite to create, edit, compose, or convert bitmap images
      jq # https://github.com/jqlang/jq # Command-line JSON processor
      yq # https://github.com/kislyuk/yq # Command-line YAML/XML/TOML processor - jq wrapper for YAML, XML, TOML documents
    ]
    ++ gui_packages
    ++ unfree_gui_packages;
}
