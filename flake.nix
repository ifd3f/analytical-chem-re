{
  description = "Analytical Chemistry Reverse Engineering";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    naersk.url = "github:nix-community/naersk/master";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    ravedude.url = "github:Rahix/avr-hal?dir=ravedude";
  };

  outputs = { self, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let avr-shell = import ./nix/avr-shell inputs system;
      in { devShells.avr = avr-shell; });
}
