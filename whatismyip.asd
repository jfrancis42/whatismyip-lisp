;;;; whatismyip.asd

(asdf:defsystem #:whatismyip
  :description "A Common Lisp client for retrieving your public IP address from various public API servers."
  :author "Jeff Francis <jeff@gritch.org>"
  :license "MIT, see file LICENSE"
  :depends-on (#:cl-json
               #:drakma
	       #:split-sequence
	       #:cl-html-parse
               #:babel)
  :serial t
  :components ((:file "package")
               (:file "whatismyip")))

