let
  pkgs = import <nixpkgs> {};
in
  pkgs.haskellPackages.callPackage ./network-arbitrary.nix {}
