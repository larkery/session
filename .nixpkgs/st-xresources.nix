{stdenv, fetchgit, pkgconfig, writeText, libX11, ncurses, libXext, libXft, fontconfig } :

stdenv.mkDerivation rec {
   version = "0.6";
   name = "st-xresources-${version}";
   src = fetchgit {
      url = "https://github.com/dcat/st-xresources.git";
      rev = "b4f6fb4476113d33092a9f22761b146d98aa39f9";
      sha256 = "0y0x24y6n5l0wgw6qivgm9aczz29fkyvyidrisnmjg3vvk0bp4wa";
   };
   buildInputs = [ pkgconfig libX11 ncurses libXext libXft fontconfig ];

   installPhase = ''
     TERMINFO=$out/share/terminfo make install PREFIX=$out
   '';
}
