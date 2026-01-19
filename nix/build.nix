# Top level module to collect all nix files
{ ... }:
{
  imports = [ ./pre-commit.nix ./pkgs.nix ./add-packages-to-checks.nix ];
  perSystem = { config, pkgs, ... }: {

    # A dev shell to aggregate all dependencies for each subproject.
    devShells.default = pkgs.mkShell {
      packages = [ ];
      shellHook =
        ''
          ${config.pre-commit.installationScript}
        '';
    };
  };
}
