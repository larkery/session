{stdenv, python36}:

stdenv.mkDerivation {
   name = "i3pop-1.0.0";
   buildInputs = [(python36.withPackages (p : [p.i3ipc]))];
   unpackPhase = ":";
   installPhase = "install -m755 -D ${./i3pop.py} $out/bin/i3-pop";
}
