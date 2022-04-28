;;;; solar.asd

(asdf:defsystem #:solar
  :description "Get solar weather information from NOAA."
  :author "Jeff Francis <jeff@gritch.org>"
  :license "MIT, see file LICENSE"
  :depends-on (#:cl-json
	       #:jeffutils
	       #:babel
	       #:drakma)
  :serial t
  :components ((:file "package")
               (:file "solar")))
