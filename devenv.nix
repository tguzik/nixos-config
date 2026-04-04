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

    sops # Secret management, https://github.com/getsops/sops
    age # Secret encryption, https://github.com/FiloSottile/age + https://github.com/Mic92/sops-nix
    ssh-to-age # Create age key based on machine's SSH key https://github.com/Mic92/ssh-to-age

    deadnix # Find and remove dead code in .nix files
    nvd # Display a diff between Nix profiles/flakes/generations
    statix # Static analysis of .nix files
  ];

  git-hooks.hooks = {
    deadnix.enable = true;
    gitlint.enable = true;
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
    nixfmt.enable = true;
    no-commit-to-branch.enable = false;
    statix.enable = true;
    shellcheck.enable = true;
    trufflehog.enable = true;
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
