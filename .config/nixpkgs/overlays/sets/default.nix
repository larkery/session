self: super:

{
  commonPackages = self.buildEnv {
    name = "common-packages";
    paths = with self; [
      gtk-engine-murrine
      zuki-themes
      vanilla-dmz
      emacs emacs-pdf-tools graphviz aspell aspellDicts.en w3m

      notmuch isync msmtp html-tidy xmlstarlet

      gitAndTools.gitFull
      vcsh
      mr
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

      polybar
    ];
  };


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
