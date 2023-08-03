{ nixpkgs, rust-overlay, naersk, ravedude, ... }:
system:
let
  pkgs = import nixpkgs {
    inherit system;
    overlays = [ (import rust-overlay) ];
  };

  toolchain =
    (pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml).override {
      extensions = [ "rust-src" ];
    };

  naersk' = pkgs.callPackage naersk {
    cargo = toolchain;
    rustc = toolchain;
  };

in pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    toolchain
    pkg-config
    pkgsCross.avr.buildPackages.gcc
    ravedude.packages."${system}".default
  ];
}
