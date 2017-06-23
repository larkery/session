self: super:

{
   gisPackages = self.buildEnv {
      name = "gis-packages";
      paths = with self; [
         qgis grass gdal spatialite_tools
      ];
   };

   themePackages = self.buildEnv {
      name = "theme-packages";
      paths = with self; [
         theme-vertex vanilla-dmz
         gtk-engine-murrine
      ];
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
        ];
     })];
   };

   commonPackages = self.buildEnv {
      name = "common-packages";
      paths = with self; [
         emacs emacs-pdf-tools graphviz aspell aspellDicts.en w3m

         notmuch isync msmtp html-tidy xmlstarlet

         gitAndTools.gitFull vcsh mr
         pass gnupg

         file yad # for xdg-open

         man-pages
         acpi

         zip unzip
         ag most htop jq which sqlite

         pamixer
         redshift
         xss-lock
         rxvt_unicode-with-plugins

         wpa_supplicant_gui

         xclip xorg.xclock xdotool xorg.xkill xorg.xbacklight

         libnotify dunst

      ];
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
