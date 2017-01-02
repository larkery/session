{stdenv, pkgconfig, flac, curl, fetchurl, cdparanoia, imagemagick, libdiscid, libcddb, automake, autoconf}:

stdenv.mkDerivation rec {
   version = "0.11";
   name = "RipRight-${version}";
   src = fetchurl {
      url = "http://www.mcternan.me.uk/ripright/software/ripright-0.11.tar.gz";
      sha256 = "1dvnggjsfp5gc0smqcgbvq3zn2h81aqm8ydg9giw2sdq61q9p1hm";
   };

   buildInputs = [pkgconfig flac curl cdparanoia imagemagick libdiscid libcddb automake autoconf];
}
