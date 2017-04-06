self: super:

{
    emacs25 =
    let
      patch = ./patches/0001-Allow-minibuffer-to-shrink-to-zero-lines.patch;
      emacsNoGTK = (super.emacs25.overrideAttrs
                     (a : {patches = a.patches ++ [patch];}))
                     .override { withGTK2 = false; withGTK3 = false; };
    in emacsNoGTK;

    dmenu = super.dmenu.override {
      patches = [ ./patches/dmenu-number-output.patch ];
    };

    emacs-pdf-tools = (super.callPackage ./pdf-tools.nix {});

    pass = super.pass.override {gnupg = self.gnupg21;};

    xosview = (super.callPackage ./xosview.nix {});

    ripright = (super.callPackage ./ripright.nix {});

    st-xresources = (super.callPackage ./st-xresources.nix {});

    gdal = (super.callPackage ./gdal.nix {});

    grass72 = (super.callPackage ./grass.nix {});

    abunchoftags = (super.callPackage ./abunchoftags.nix {});
}
