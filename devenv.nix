# The main point of using DevEnv for NixOS config is to:
#
# 1) Ensure basic utilities are always available, regardless on which system the edits are made
# 2) Leverage integrations with pre-commit hooks
#
{ pkgs, ... }:
{
  # See full reference at https://devenv.sh/reference/options/

  # https://devenv.sh/languages/
  languages = {
    nix = {
      enable = true;
      lsp.package = pkgs.nixd;
    };
  };

  # https://devenv.sh/packages/
  # https://search.nixos.org/packages
  packages = with pkgs; [
    git
    go-task
    gnupg

    # Secret management
    sops # Secret management, https://github.com/getsops/sops
    age # Secret encryption, https://github.com/FiloSottile/age + https://github.com/Mic92/sops-nix
    ssh-to-age # Create age key based on machine's SSH key https://github.com/Mic92/ssh-to-age

    # Derivation diffing
    nix-diff # https://hackage.haskell.org/package/nix-diff # Explain why two Nix derivations differ
    dix # https://github.com/faukah/dix # Blazingly fast tool to diff Nix related things
  ];

  git-hooks.hooks = {
    # Basics
    gitlint.enable = true;
    no-commit-to-branch.enable = false;
    trufflehog.enable = true;

    # Keep nix files nice and tidy
    deadnix.enable = true;
    nixfmt.enable = true;
    shellcheck.enable = true;
    statix.enable = true;

    # Format non-nix files
    markdownlint = {
      enable = true;
      settings.configuration = {
        MD013 = {
          line_length = 120;
        };
        MD033 = false;
        MD034 = false;
      };
    };
    yamllint = {
      enable = true;
      settings.configuration = ''
        extends: relaxed
        rules:
          line-length:
            max: 150
      '';
    };
  };

  enterShell = ''
    # Do nothing
  '';

  enterTest = ''
    # Do nothing
  '';
}
