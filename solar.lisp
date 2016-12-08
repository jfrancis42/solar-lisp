;;;; solar.lisp

(in-package #:solar)

(defun get-solar-flux ()
  (cons :flux (parse-integer (cdr (assoc :*flux (json:decode-json-from-string (babel:octets-to-string (first (multiple-value-list (drakma:http-request "http://services.swpc.noaa.gov/products/summary/10cm-flux.json" :method :get))))))))))

(defun get-kp-index ()
  (cons :kp (second (first (last (json:decode-json-from-string (babel:octets-to-string (first (multiple-value-list (drakma:http-request "http://services.swpc.noaa.gov/products/noaa-estimated-planetary-k-index-1-minute.json" :method :get))))))))))

(defun get-solar-data ()
  (let ((mag (json:decode-json-from-string (babel:octets-to-string (first (multiple-value-list (drakma:http-request "http://services.swpc.noaa.gov/products/summary/solar-wind-mag-field.json" :method :get))))))
	(wind (json:decode-json-from-string (babel:octets-to-string (first (multiple-value-list (drakma:http-request "http://services.swpc.noaa.gov/products/summary/solar-wind-speed.json" :method :get)))))))
    (list (cons :wind-speed (parse-integer (cdr (assoc :*wind-speed wind)))) (cons :bt (parse-integer (cdr (assoc :*bt mag)))) (cons :bz (parse-integer (cdr (assoc :*bz mag)))))))

(defun get-xray-event ()
  (json:decode-json-from-string (babel:octets-to-string (first (multiple-value-list (drakma:http-request "http://services.swpc.noaa.gov/products/latest-xray-event.json" :method :get))))))

(defun space-weather ()
  (let ((mag (json:decode-json-from-string (babel:octets-to-string (first (multiple-value-list (drakma:http-request "http://services.swpc.noaa.gov/products/summary/solar-wind-mag-field.json" :method :get))))))
	(wind (json:decode-json-from-string (babel:octets-to-string (first (multiple-value-list (drakma:http-request "http://services.swpc.noaa.gov/products/summary/solar-wind-speed.json" :method :get))))))
	(flux (parse-integer (cdr (assoc :*flux (json:decode-json-from-string (babel:octets-to-string (first (multiple-value-list (drakma:http-request "http://services.swpc.noaa.gov/products/summary/10cm-flux.json" :method :get)))))))))
	(xray (json:decode-json-from-string (babel:octets-to-string (first (multiple-value-list (drakma:http-request "http://services.swpc.noaa.gov/products/latest-xray-event.json" :method :get))))))
	(kp (second (first (last (json:decode-json-from-string (babel:octets-to-string (first (multiple-value-list (drakma:http-request "http://services.swpc.noaa.gov/products/noaa-estimated-planetary-k-index-1-minute.json" :method :get))))))))))
    (list
     (cons :flux flux)
     (cons :kp kp)
     (cons :wind-speed (parse-integer (cdr (assoc :*wind-speed wind))))
     (cons :bt (parse-integer (cdr (assoc :*bt mag))))
     (cons :bz (parse-integer (cdr (assoc :*bz mag))))
     (cons :xray xray))))
  
;; (defun sfi-to-ssn (sfi)
;;   (+ (/ (* 89 sfi sfi) 100000) (/ (* 91 sfi) 125) 63.7))
