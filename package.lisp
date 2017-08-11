;;;; package.lisp

(defpackage #:solar
  (:use #:cl)
  (:export :space-weather
	   :get-xray-event
	   :get-kp-index
	   :get-solar-flux
	   :get-solar-data))
