{ stdenv, fetchurl, flex, bison, pkgconfig, zlib, libtiff, libpng, fftw
, cairo, readline, ffmpeg, makeWrapper, wxGTK30, netcdf, blas
, proj, gdal, geos, sqlite, postgresql, mysql, python2Packages
}:

stdenv.mkDerivation {
  name = "grass-7.2.0";
  src = fetchurl {
    url = https://grass.osgeo.org/grass72/source/grass-7.2.0.tar.gz;
    sha256 = "0l07yxya0i1hndg13dj5bbq967r8v23bsiqmw063766czhy0rg7h";
  };

  buildInputs = [ flex bison zlib proj gdal libtiff libpng fftw sqlite pkgconfig cairo
  readline ffmpeg makeWrapper wxGTK30 netcdf geos postgresql mysql.client blas ]
    ++ (with python2Packages; [ python dateutil wxPython30 numpy sqlite3 ]);

  configureFlags = [
    "--with-proj-share=${proj}/share/proj"
    "--without-opengl"
    "--with-readline"
    "--with-wxwidgets"
    "--with-netcdf"
    "--with-geos"
    "--with-postgres" "--with-postgres-libs=${postgresql.lib}/lib/"
    # it complains about missing libmysqld but doesn't really seem to need it
    "--with-mysql" "--with-mysql-includes=${stdenv.lib.getDev mysql.client}/include/mysql"
    "--with-blas"
  ];

  /* Ensures that the python script run at build time are actually executable;
   * otherwise, patchShebangs ignores them.  */
  postConfigure = ''
    find scripts -iname \*.py -exec chmod +x '{}' ';'
    for d in gui lib scripts temporal tools; do
      patchShebangs $d
    done
  '';

  postInstall = ''
    wrapProgram $out/bin/grass72 \
    --set PYTHONPATH $PYTHONPATH \
    --set GRASS_PYTHON ${python2Packages.python}/bin/${python2Packages.python.executable} \
    --suffix LD_LIBRARY_PATH ':' '${gdal}/lib'
    ln -s $out/grass-*/lib $out/lib
  '';

  enableParallelBuilding = true;

  meta = {
    homepage = http://grass.osgeo.org/;
    description = "GIS software suite used for geospatial data management and analysis, image processing, graphics and maps production, spatial modeling, and visualization";
    license = stdenv.lib.licenses.gpl2Plus;
    platforms = stdenv.lib.platforms.all;
  };
}
