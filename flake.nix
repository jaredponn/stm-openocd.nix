{
  description = "STM OpenOCD Packaging";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=25.11";

    flake-parts.url = "github:hercules-ci/flake-parts";

    git-hooks-nix.url = "github:cachix/git-hooks.nix";
    git-hooks-nix.inputs.nixpkgs.follows = "nixpkgs";

    # STM firmware dependencies
    stm-openocd = {
      url = "git+https://github.com/STMicroelectronics/OpenOCD?ref=openocd-cubeide-r6&submodules=1";
      flake = false;
    };
  };

  outputs = inputs@{ flake-parts, ... }: flake-parts.lib.mkFlake { inherit inputs; } {
    imports = [ ./nix/build.nix ./packages/build.nix ];
    systems = [ "x86_64-linux" ];
  };
}
