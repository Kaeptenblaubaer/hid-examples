# default.nix
let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs { };
in 
  pkgs.haskellPackages.ghcWithHoogle (p: with p; [base bytestring text mtl lens])