self: super:

{
  gisPackages = self.buildEnv {
    name = "gis-packages";
    paths = with self; [
      qgis grass gdal spatialite_tools
    ];
  };

  rEnvironment = self.buildEnv {
    name = "r-environment";
    paths = [(self.rWrapper.override {
      packages = with self.rPackages; [
        ggplot2 dplyr tidyr
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
