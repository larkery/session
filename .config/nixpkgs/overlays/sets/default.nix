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
      ];
   };

   rEnvironment = self.buildEnv {
      name = "r-environment";
      paths = [(self.rWrapper.override {
        packages = with self.rPackages; [
           ggplot2 dplyr tidyr purrr openxlsx fuzzyjoin assertthat
        ];
     })];
   };

   commonPackages = self.buildEnv {
      name = "common-packages";
      paths = with self; [
         emacs
         emacs-pdf-tools
         graphviz
         notmuch
         isync
         msmtp
         man-pages
         acpi
         vcsh
         zip
         unzip
         gitAndTools.gitFull
         ag
         mr
         redshift
         xss-lock
         rxvt_unicode-with-plugins
         pass
         gnupg
         most
         w3m
         wpa_supplicant_gui
         xclip
         xorg.xclock
         xdotool
         xorg.xkill
         aspell
         aspellDicts.en
         jq
         libnotify
         htop
         file
      ];
   };

   clojurePackages = self.buildEnv {
      name = "clojure-packages";
      paths = with self; [clojure leiningen];
   };

   javaPackages = self.buildEnv {
      name = "java-packages";
      paths = with self; [jdk maven gradle];
   };
}
