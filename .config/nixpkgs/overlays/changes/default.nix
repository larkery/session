self: super:

{
  # emacs25 =
  #   (super.emacs25.overrideAttrs
  #   (a :
  #     {
  #       patches = a.patches ++ [ ./patches/emacs-double-buffer.patch ];
  #       configureFlags = a.configureFlags ++ ["--with-imagemagick"
  #                                             "--with-x-toolkit=athena"];
  #       buildInputs = a.buildInputs ++ [self.imagemagick.dev];
  #     })).override { withGTK2 = false; withGTK3 = false; srcRepo = true; };

  mplayer = super.mplayer.override {
    x264Support = true;
    x264 = self.x264;
  };

  ripright = (super.callPackage ./ripright.nix {});

  xcopy = (super.callPackage ./xcopy.nix {});

  xwinmosaic = (super.xwinmosaic.overrideAttrs (a : {
    patches = [./patches/xwinmosaic-print-id.patch];
  }));

  i3pop = (super.callPackage ./i3pop.nix {});

}
