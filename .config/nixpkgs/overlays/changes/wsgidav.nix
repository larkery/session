{stdenv, fetchurl, python35Packages}
:
python35Packages.buildPythonPackage rec {
   name = "wsgidav-${version}";
   version = "2.2.1";

   src = fetchurl {
      url = https://github.com/mar10/wsgidav/archive/v2.2.1.tar.gz;
      sha256 = "1yj96ci2mdq229af2ijvlfbqbhrpaymk92ix99wzb02r8r1kzcsy";
   };
   doCheck = false;
   # something about homeless shelter
   buildInputs = with python35Packages; [pytest virtualenv];
   # cheroot does not exist in nix
   propagatedBuildInputs = with python35Packages; [ defusedxml cheroot ];
}
