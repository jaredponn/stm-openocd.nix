# Module for modifying `pkgs`
{ inputs, lib, ... }:
{
  perSystem = { system, ... }: {
    _module.args = {
      pkgs = import inputs.nixpkgs {
        overlays = [
        ];
        inherit system;
      };
    };
  };
}
