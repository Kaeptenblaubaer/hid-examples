{ nixpkgs ? import <nixpkgs> {}, compiler ? "ghc865Binary" }:
nixpkgs.pkgs.haskell.packages.${compiler}.callPackage ./foo.nix { }
