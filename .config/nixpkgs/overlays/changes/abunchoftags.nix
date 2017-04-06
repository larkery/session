{stdenv, fetchgit, scons, pkgconfig, glibmm, gmime, notmuch, boost}:
stdenv.mkDerivation rec {
   name = "abunchoftags-${version}";
   version = "20160909";
   src = fetchgit {
      url = "https://github.com/gauteh/abunchoftags.git";
      rev = "a9634614036f485252d56d0abd651277ab4cc1d5";
      sha256 = "1601wm8w71iiy1hhpahd3s296jf0l53rp7zhblqrcmlhm2k0x3xn";
      fetchSubmodules = false;
   };

   buildInputs = [scons pkgconfig glibmm gmime notmuch boost];
   patchPhase = ''
   sed -ie 's/GIT_DESC =/GIT_DESC = \"${name}\" #/g' SConstruct
   sed -ie 's/env = Environment ()/env = Environment(ENV = os.environ)/g' SConstruct
   '';
   buildPhase = "scons";
   installPhase = ''
   mkdir -p $out/bin
   cp keywsync $out/bin/
   if [ -e notmuch_get_revision ]; then
      cp notmuch_get_revision $out/bin/
   fi
   '';
}
