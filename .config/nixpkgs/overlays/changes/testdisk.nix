{ stdenv, fetchurl, ncurses, libuuid }:

stdenv.mkDerivation rec {
   name = "testdisk-${version}";
   version = "7.0";

   buildInputs = [ ncurses libuuid ];

   src = fetchurl {
      url = "https://www.cgsecurity.org/testdisk-${version}.tar.bz2";
      sha256 = "0ba4wfz2qrf60vwvb1qsq9l6j0pgg81qgf7fh22siaz649mkpfq0";
   };


}
