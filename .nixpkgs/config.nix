{
   allowUnfree = true;

   packageOverrides = super: let self=super.pkgs; in rec {
     dmenu = super.dmenu.override {
       patches = [ ./patches/dmenu-number-output.patch ];
     };
     #emacs24 has a silly bug with xft fonts.
     emacs = super.lib.overrideDerivation
       (super.emacs.override {
         withGTK3 = false;
         withGTK2 = false;
         })
       (attrs : { patches = super.emacs.patches ++ [ ./patches/emacs-xft.patch ]; }) ;

     pass = super.pass.override {gnupg = self.gnupg21;};

     # secpwgen = super.stdenv.mkDerivation {
     #    name = "secpwgen-1.3";
     #    src = super.fetchFromGitHub {
     #       owner = "itoffshore";
     #       repo = "secpwgen";
     #       rev = "c454e82808497834b33ada4b179e0b2e0e6d3745";
     #       sha256 = "0md2fkwdxlx1dhq2y6rdvja5lhh3ki62ylqrk14svnq2pqg8yprb";
     #    };
     # };

     # pinentry-xlib = super.stdenv.mkDerivation {
     #    name = "pinentry-xlib-1.1";
     #    src = super.fetchFromGitHub {
     #      owner = "msharov";
     #      repo = "pinentry-xlib";
     #      rev = "049fb76a7c5f8a7009c10518b8d82670e0e626cf";
     #      sha256 = "0587lmbb4zqwgmxbqqy1pd9y42z4vgi5vadxwww3zy86ima43mjp";
     #    };
     #    # does not yet work
     #    buildInputs = [self.xlibs.libX11];
     # };
   };
}
