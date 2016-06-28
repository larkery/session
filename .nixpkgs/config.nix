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

     epass = import ./epass;
   };
}
