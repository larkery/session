{
   allowUnfree = true;

   packageOverrides = super: let self=super.pkgs; in rec {
     dmenu = super.dmenu.override {
       patches = [ ./patches/dmenu-number-output.patch ];
     };

     emacs25 = super.lib.overrideDerivation
        (super.emacs25.override
          { withGTK2 = false; withGTK3 = false; })
        (attrs : { patches = (super.emacs25.patches) ++
            [ ./patches/0001-Allow-minibuffer-to-shrink-to-zero-lines.patch ]
           ; });

     emacs-pdf-tools = (super.callPackage ./pdf-tools.nix {});

     pass = super.pass.override {gnupg = self.gnupg21;};

     xosview = (super.callPackage ./xosview.nix {});

     ripright = (super.callPackage ./ripright.nix {});

     st-xresources = (super.callPackage ./st-xresources.nix {});

     gdal = (super.callPackage ./gdal.nix {});

     grass72 = (super.callPackage ./grass.nix {});
   };
}
