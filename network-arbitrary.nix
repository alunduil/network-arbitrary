let
  config = {
    packageOverrides = pkgs: rec {
      haskellPackages = pkgs.haskellPackages.override {
        overrides = haskellPackagesNew: haskellPackagesOld: rec {

          network-arbitrary =
            haskellPackagesNew.callPackage ./default.nix { };

        };
      };
    };
  };

  pkgs = import <nixpkgs> { inherit config; };
in
  { network-arbitrary = pkgs.haskellPackages.network-arbitrary;
  }
