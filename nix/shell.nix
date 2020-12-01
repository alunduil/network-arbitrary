let
  pkgs = import <nixpkgs> {};
  network-arbitrary = import ./default.nix;
in
  pkgs.mkShell {
    inputsFrom = [ network-arbitrary ];
    buildInputs = [
      pkgs.cabal-install
      pkgs.cabal2nix
      pkgs.haskell-ci
      pkgs.haskellPackages.stylish-haskell
      pkgs.hlint
      pkgs.pre-commit
    ];
  }
