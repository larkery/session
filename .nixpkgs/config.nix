{
   allowUnfree = true;

   packageOverrides = super: let self=super.pkgs; in rec {
     dmenu = super.dmenu.override {
       patches = [ ./patches/dmenu-number-output.patch ];
     };

     emacs = super.emacs.override {
         withGTK2 = false;
         withGTK3 = false;
     };
     #   (super.emacs.override {
     #     withGTK3 = false;
     #     withGTK2 = false;
     #     })
     #   (attrs : rec {
     #     name = "emacs-24.5";
     #     src = super.fetchurl {
     #        url = "mirror://gnu//emacs/${name}.tar.xz";
     #        sha256 = "0kn3rzm91qiswi0cql89kbv6mqn27rwsyjfb8xmwy9m5s8fxfiyx";
     #     };
     #     patches = super.emacs.patches ++ [ ./patches/emacs-xft.patch ]; }) ;

     pass = super.pass.override {gnupg = self.gnupg21;};

     interrobang = with self;
     stdenv.mkDerivation {
        name="interrobang";
        version="20160331";
        src=fetchFromGitHub {
           owner="larkery";
           repo="interrobang";
           rev="6aefadf18f69532d2b4b4d3fc825ef79d8d5254e";
           sha256="0r9r5a5ag9zv0ags66mjz89473cs97hg9bl8526iwhjassw4v8hx";
        };
        buildInputs = [ xlibs.libX11 ];
        preBuild=''
          export DESTDIR=$out
          export PREFIX=""
          printenv
        '';

      };
   };
}
