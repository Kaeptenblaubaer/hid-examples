{ nixpkgs ? import <nixpkgs> {}, compiler ? "ghc865Binary" }:
(import ./default.nix { inherit nixpkgs compiler; }).env