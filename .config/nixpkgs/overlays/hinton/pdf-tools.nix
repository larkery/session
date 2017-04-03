{stdenv, fetchurl, libpng, zlib, poppler, pkgconfig, autoconf, automake, emacs25}:

let version = "0.70";

in stdenv.mkDerivation {
  name = "pdf-tools-${version}";

  src = fetchurl {
    url = "https://github.com/politza/pdf-tools/archive/v${version}.tar.gz";
    sha256 = "1m0api6wiawswyk46bdsyk6r5rg3b86a4paar6nassm6x6c6vr77";
  };

  buildInputs = [ libpng zlib poppler pkgconfig autoconf automake emacs25 ];

  preBuild = ''
     patchShebangs ./server/autogen.sh
  '';

  postBuild = ''
    emacs -L lisp/ --batch -f batch-byte-compile lisp/*.el
  '';

 installPhase = ''
   install -d $out/share/emacs/site-lisp
   install ./lisp/*.el ./lisp/*.elc $out/share/emacs/site-lisp
   install -d $out/bin
   install ./server/epdfinfo $out/bin
 '';

  meta = {
    description = "Emacs support library for PDF files.";
    longDescription = ''
    PDF Tools is, among other things, a replacement of DocView for PDF
    files. The key difference is, that pages are not prerendered by
    e.g. ghostscript and stored in the file-system, but rather created
    on-demand and stored in memory.
   '';

    homepage = https://github.com/politza/pdf-tools;
    platforms = stdenv.lib.platforms.all;
    # maintainers = [ stdenv.lib.maintainers.kmicu ];
    # license = stdenv.lib.licenses.gpl3;
    licences = [ stdenv.lib.licenses.gpl3
                 stdenv.lib.licenses.mit # SyncTeX parser
               ];
  };
}