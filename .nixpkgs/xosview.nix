{stdenv, fetchurl, libX11, libXpm}:

let version = "1.19";
in
stdenv.mkDerivation {
   name = "xosview-${version}";

   src = fetchurl {
     url = "http://www.pogo.org.uk/~mark/xosview/releases/xosview-${version}.tar.gz";
     sha256 = "1brcnbi0j6xyhvnav74mv78xb4qfkqdrhcfbknx06g4nq7kakdh8";
   };

   buildInputs = [libX11 libXpm];

   buildPhase = ''
   export PREFIX=$out
   make
   make install PREFIX=$out
   '';
}
