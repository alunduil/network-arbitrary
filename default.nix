{ mkDerivation, base, hspec, http-media, network-uri, QuickCheck
, stdenv
}:
mkDerivation {
  pname = "network-arbitrary";
  version = "0.1.0.0";
  src = ./.;
  libraryHaskellDepends = [ base http-media network-uri QuickCheck ];
  testHaskellDepends = [
    base hspec http-media network-uri QuickCheck
  ];
  homepage = "https://github.com/alunduil/network-arbitrary";
  description = "Arbitrary Instances for Network Types";
  license = stdenv.lib.licenses.mit;
}
