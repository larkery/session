{stdenv, fetchurl, unzip} :
stdenv.mkDerivation rec {
   name = "onestepback-gtk-theme-${version}";
   version = "0.96";

   src = fetchurl {
       url = "https://dl.opendesktop.org/api/files/download/id/1501207445/OneStepBack.zip";
       sha256 = "01hswpqlznr3k583x39d69lxxrbkifdq7p3pdpm21knlm08lsjm1";
   };

   unpackPhase = ''
   ${unzip}/bin/unzip $src
   '';

   installPhase = ''
   mkdir -p $out/share/themes
   cp -R OneStepBack $out/share/themes/
   '';
}
