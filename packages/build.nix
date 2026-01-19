# Top level module to collect all nix files
{ inputs, config, ... }:
{
  imports = [ ];

  perSystem = { config, pkgs, ... }: {
    #####################
    # STM OpenOCD derivation
    #####################
    packages.default = pkgs.stdenv.mkDerivation {
      pname = "openocd";
      version = "0.12.0";
      src = inputs.stm-openocd;
      nativeBuildInputs = [
        pkgs.pkg-config
        pkgs.autoconf
        pkgs.automake
        pkgs.git
        pkgs.pkgconf
        pkgs.libtool
        pkgs.which

        pkgs.tcl
      ];
      buildInputs = [
        pkgs.libusb1
        pkgs.hidapi
        pkgs.jimtcl
        pkgs.libftdi1
        pkgs.libjaylink

        pkgs.libgpiod_1
      ];

      configurePhase = ''
        SKIP_SUBMODULE=1 ./bootstrap
        ./configure \
           --prefix="$out" \
           --disable-werror \
           --enable-jtag_vpi \
           --enable-remote-bitbang \
           --enable-buspirate \
           --enable-ftdi \
           --enable-linuxgpiod \
           --enable-sysfsgpio
      '';

      buildPhase = ''
        make
      '';
      installPhase = ''
        make install

        mkdir -p "$out/etc/udev/rules.d"
        rules="$out/share/openocd/contrib/60-openocd.rules"
        if [ ! -f "$rules" ]; then
            echo "$rules is missing, must update the Nix file."
            exit 1
        fi
        ln -s "$rules" "$out/etc/udev/rules.d/"
      '';

      doInstallCheck = true;
    };
  };

  flake.overlays.default = _self: super: {
    stm-openocd = config.flake.packages.${super.system}.default;
  };
}
