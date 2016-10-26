{
   allowUnfree = true;

   packageOverrides = super: let self=super.pkgs; in rec {
     dmenu = super.dmenu.override {
       patches = [ ./patches/dmenu-number-output.patch ];
     };

     emacs25 = super.emacs25.override {
         withGTK2 = false;
         withGTK3 = false;
     };

     pass = super.pass.override {gnupg = self.gnupg21;};
   };
}
