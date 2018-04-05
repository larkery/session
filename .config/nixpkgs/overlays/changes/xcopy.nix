{stdenv, fetchgit, halibut, xorg} :

stdenv.mkDerivation rec {
  name = "xcopy-${version}";
  version = "2018-02-21";

  buildInputs = [halibut xorg.libX11 xorg.libXt];

  src = fetchgit {
    url = "https://git.tartarus.org/simon/xcopy.git";
    rev = "5595a9622bb9327772f5773f11b083b464e6b26f";
    sha256 = "00xdfyz6qjk4ncgaq1kij56218jbq93p1ck2q9nrc2362dmnxqf6";
  };

  installPhase = ''
    make install PREFIX=$out
  '';
}
