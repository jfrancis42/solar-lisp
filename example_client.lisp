(ql:quickload :pushover)
(ql:quickload :creds)
(ql:quickload :solar)

(creds:load-creds)

(defun send-solar-update ()
  (pushover:send-pushover (creds:get-cred "potoken") (creds:get-cred "pouser") (format nil "~A ~A" (solar:get-solar-flux) (solar:get-kp-index)) :sound :cosmic))

(defun bin ()
  "Write a an executable compiled version of the code to disk."
  (sb-ext:save-lisp-and-die "solar_report" :toplevel #'send-solar-update :executable t :purify t :compression 9))
