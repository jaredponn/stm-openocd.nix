# Module for setting up git hooks
{ inputs, ... }:
{
  imports = [ inputs.git-hooks-nix.flakeModule ];

  perSystem = { config, pkgs, ... }:
    {
      pre-commit.settings.hooks = {
        # Nix formatting
        nixpkgs-fmt.enable = true;

        # Spelling
        typos.enable = true;
        typos.excludes =
          [
          ];

        # Markdown formatting
        mdformat.enable = true;

      };
    };
}
