;;;; solar.lisp

(in-package #:solar)

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

(defun interpret-report (solar-report)
  (let ((sfi (jeff:cdr-assoc :sfi solar-report))
	(a (jeff:cdr-assoc :a solar-report))
	(k (jeff:cdr-assoc :k solar-report)))
    (cond
      ((>= sfi 170) (format t "SFI (~A) is exceptional. High-band DX likely.~%" sfi))
      ((>= sfi 120) (format t "SFI (~A) is good. 20m/40m DX likely.~%" sfi))
      ((>= sfi 70) (format t "SFI (~A) is OK. Single-hop contacts likely.~%" sfi))
      (t  (format t "SFI (~A) sucks.~%" sfi)))
    (cond
      ((<= k 3) (format t "K-Index (~A) is great.~%" k))
      ((<= k 5) (format t "K-Index (~A) is good.~%" k))
      (t (format t "K-Index (~A) sucks.~%" k)))
    (cond
      ((<= a 15) (format t "A-Index (~A) is good.~%" a))
      (t (format t "A-Index (~A) is not good.~%" a)))))

;;; Local Variables:
;;; mode: Lisp
;;; coding: utf-8
;;; End:
