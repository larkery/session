self: super:

{
  emacs25 =
    (super.emacs25.overrideAttrs
    (a :
      {
        patches = a.patches ++ [
#          ./patches/0001-Allow-minibuffer-to-shrink-to-zero-lines.patch
          ./patches/emacs-double-buffer.patch
        ];
      })).override { withGTK2 = false; withGTK3 = false; srcRepo = true; };

  mplayer = super.mplayer.override {
    x264Support = true;
    x264 = self.x264;
  };

  emacs-pdf-tools = (super.callPackage ./pdf-tools.nix {});

  pass = super.pass.override {gnupg = self.gnupg;};

  ripright = (super.callPackage ./ripright.nix {});

#  gdal = (super.callPackage ./gdal.nix {});

  grass72 = (super.callPackage ./grass.nix {});

  abunchoftags = (super.callPackage ./abunchoftags.nix {});

  xcopy = (super.callPackage ./xcopy.nix {});
  #  pulseaudio-dlna = (super.callPackage ./pulseaudio-dlna.nix {});
}
