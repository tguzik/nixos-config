# The main point of using DevEnv for NixOS config is to:
#
# 1) Ensure basic utilities are always available, regardless on which system the edits are made
# 2) Leverage integrations with pre-commit hooks
#
{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
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
  ];

  git-hooks.hooks = {
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
