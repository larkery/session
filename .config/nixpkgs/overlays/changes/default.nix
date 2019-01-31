self: super:

{
  ripright = (super.callPackage ./ripright.nix {});

  xcopy = (super.callPackage ./xcopy.nix {});

  i3pop = (super.callPackage ./i3pop.nix {});

  #qgis = (super.callPackage ./qgis.nix {});
}
