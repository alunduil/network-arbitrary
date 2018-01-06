{ mkDerivation, base, hspec, network-uri, QuickCheck, stdenv }:
mkDerivation {
  pname = "network-arbitrary";
  version = "0.1.0.0";
  src = ./.;
  libraryHaskellDepends = [ base network-uri QuickCheck ];
  testHaskellDepends = [ base hspec network-uri QuickCheck ];
  homepage = "https://github.com/alunduil/network-arbitrary";
  description = "Arbitrary Instances for Network Types";
  license = stdenv.lib.licenses.mit;
}
