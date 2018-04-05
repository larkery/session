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

  compton-custom = super.compton.overrideAttrs
    (_ :
    {
      name = "compton-custom";
      src =
        super.fetchgit {
        url = "https://github.com/larkery/compton.git";
        rev = "3a28338cd8bd51188dbf000bfdf9404502a26ac8";
        sha256 = "07lyw2df9cjcjmjjv1j70m1j4k8r9hbqivxb2vp4fl8zrxb2rq38";
      };
    });

  emacs-pdf-tools = (super.callPackage ./pdf-tools.nix {});

  pass = super.pass.override {gnupg = self.gnupg;};

  ripright = (super.callPackage ./ripright.nix {});

#  gdal = (super.callPackage ./gdal.nix {});

  grass72 = (super.callPackage ./grass.nix {});

  abunchoftags = (super.callPackage ./abunchoftags.nix {});

  xcopy = (super.callPackage ./xcopy.nix {});
  #  pulseaudio-dlna = (super.callPackage ./pulseaudio-dlna.nix {});
}
