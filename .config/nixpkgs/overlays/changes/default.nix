self: super:

{
  emacs25 =
    let
    patch0 = ./patches/0001-Allow-minibuffer-to-shrink-to-zero-lines.patch;
  patch1 = ./patches/emacs-double-buffer.patch;
  emacsNoGTK = (super.emacs25.overrideAttrs
    (a : {
      patches = a.patches ++ [patch0 patch1];
    }))
      .override { withGTK2 = false; withGTK3 = false;
    srcRepo = true; };
in emacsNoGTK;

  mplayer = super.mplayer.override {
    x264Support = true;
    x264 = self.x264;
  };


  emacs-pdf-tools = (super.callPackage ./pdf-tools.nix {});

  pass = super.pass.override {gnupg = self.gnupg;};

  ripright = (super.callPackage ./ripright.nix {});

  gdal = (super.callPackage ./gdal.nix {});

  grass72 = (super.callPackage ./grass.nix {});

  abunchoftags = (super.callPackage ./abunchoftags.nix {});

  #  pulseaudio-dlna = (super.callPackage ./pulseaudio-dlna.nix {});
}
