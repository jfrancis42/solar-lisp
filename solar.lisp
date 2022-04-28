;;;; solar.lisp

(in-package #:solar)

(ql:quickload :jeffutils)

(defun flux ()
  (jeff:cdr-assoc :flux
		  (first
		   (json:decode-json-from-string
		    (babel:octets-to-string
		     (first
		      (multiple-value-list
		       (drakma:http-request
			"http://services.swpc.noaa.gov/json/f107_cm_flux.json"
			:method :get))))))))

(defun k-index ()
  (jeff:cdr-assoc :k--index
		  (first
		   (reverse
		    (json:decode-json-from-string
		     (babel:octets-to-string
		      (first
		       (multiple-value-list
			(drakma:http-request
			 "http://services.swpc.noaa.gov/json/boulder_k_index_1m.json"
			 :method :get)))))))))

(defun a-index ()
  (jeff:cdr-assoc :afred--1--day
		  (first
		   (json:decode-json-from-string
		    (babel:octets-to-string
		     (first
		      (multiple-value-list
		       (drakma:http-request
			"http://services.swpc.noaa.gov/json/predicted_fredericksburg_a_index.json"
			:method :get))))))))

(defun solar-report ()
  (list (cons :sfi (flux))
	(cons :k (k-index))
	(cons :a (a-index))))

;;; Local Variables:
;;; mode: Lisp
;;; coding: utf-8
;;; End:
