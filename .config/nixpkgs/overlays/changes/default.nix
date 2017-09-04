self: super:

{
    emacs25 =
    let
      patch0 = ./patches/0001-Allow-minibuffer-to-shrink-to-zero-lines.patch;
      patch1 = ./patches/emacs-double-buffer.patch;
      emacsNoGTK = (super.emacs25.overrideAttrs
                     (a : {patches = a.patches ++ [patch0 patch1];}))
                     .override { withGTK2 = false; withGTK3 = false;
                                 srcRepo = true; };
    in emacsNoGTK;

    mplayer = super.mplayer.override {
      x264Support = true;
      x264 = self.x264;
    };

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

    onestepback-gtk-theme = (super.callPackage ./onestepback.nix {});
}
