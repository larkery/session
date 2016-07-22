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

     mate-themes = super.lib.overrideDerivation
     super.mate.mate-themes

     (attrs : {
       name = "mate-themes-3.22.0";
       src = super.fetchurl {
         url = "http://pub.mate-desktop.org/releases/themes/3.22/mate-themes-3.22.0.tar.xz";
         sha256 = "0d95ascqskz33nrnslncqk5wss9kmvqd6mzp3vqvjjjpdmy68nir";
       };
     });
   };
}
