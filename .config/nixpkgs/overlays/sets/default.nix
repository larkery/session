self: super:

{
  gisPackages = self.buildEnv {
    name = "gis-packages";
    paths = with self; [
      qgis grass gdal spatialite_tools
    ];
  };

  rStudioEnv = self.buildEnv {
    name = "r-studio-environment";
    paths = [(super.rstudioWrapper.override {
      packages = with self.rPackages ; [ dplyr tidyr ggplot2 openxlsx ];
    })];
  };

  rEnvironment = self.buildEnv {
    name = "r-environment";
    paths = [(self.rWrapper.override {
      packages = with self.rPackages; [
        ggplot2 dplyr tidyr purrr openxlsx fuzzyjoin assertthat microbenchmark
        memoise testthat
        XLConnect data_table downloader
        RSQLite
        validate
        optparse
        Hmisc
        lintr
        rnrfa
        Hmisc
        memisc
        lubridate
        hexbin
        kernlab
      ];
    })];
  };

  clojurePackages = self.buildEnv {
    name = "clojure-packages";
    paths = with self; [clojure leiningen boot];
  };

  javaPackages = self.buildEnv {
    name = "java-packages";
    paths = with self; [jdk maven gradle];
  };
}
