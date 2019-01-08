self: super:

{
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
