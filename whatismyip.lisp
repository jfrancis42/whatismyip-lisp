;;;; whatismyip.lisp

(in-package #:whatismyip)

;;; "whatismyip" goes here. Hacks and glory await!

(defmacro cdr-assoc (name alist)
  "Replaces '(cdr (assoc name alist))' because it's used a bajillion
times when doing API stuff."
  `(cdr (assoc ,name ,alist :test #'equal)))

(defun get-public-ip (&optional method)
  "Fetch my public IP address from the server specified by
method. Defaults to :whatismyipaddress."
  (cond ((eq :ident-me method) (ident-me))
	((eq :icanhazip method) (icanhazip))
	((eq :ipify method) (ipify))
	((eq :dyndns method) (dyndns))
	((eq :ipinfo method) (ipinfo))
	((eq :infoip method) (infoip))
	((eq :trackip method) (trackip))
	((eq :whatismyipaddress method) (whatismyipaddress))
	((eq :ip-api method) (ip-api))
	(t (whatismyipaddress))))

(defun ident-me ()
  "Fetch my public IP address from ident.me."
  (first
   (multiple-value-list
    (drakma:http-request "http://ident.me" :method :get))))

(defun icanhazip ()
  "Fetch my public IP address from icanhazip.com."
  (remove
   #\Newline
   (first
    (multiple-value-list
     (drakma:http-request "http://icanhazip.com" :method :get)))))

(defun ipify ()
  "Fetch my public IP address from ipify.org."
  (cdr-assoc
   :ip
   (json:decode-json-from-string
    (babel:octets-to-string
     (first
      (multiple-value-list
       (drakma:http-request "http://api.ipify.org?format=json" :method :get)))))))

(defun dyndns ()
  "Fetch my public IP address from dyndns.org."
  (remove
   #\Space 
   (second
    (split-sequence:split-sequence
     #\:
     (first
      (cdr-assoc
       :body
       (cdr-assoc
	:html
	(html-parse:parse-html
	 (first
	  (multiple-value-list
	   (drakma:http-request "http://checkip.dyndns.org" :method :get)))))))))))

(defun ipinfo ()
  "Fetch my public IP address from ipinfo.io."
  (remove
   #\Newline
   (first
    (multiple-value-list
     (drakma:http-request "http://ipinfo.io/ip" :method :get)))))


(defun infoip ()
  "Fetch my public IP address from infoip.io."
  (first
   (multiple-value-list
    (drakma:http-request "http://api.infoip.io/ip" :method :get))))

(defun trackip ()
  "Fetch my public IP address from trackip.net."
  (cdr-assoc
   :+ip+
   (json:decode-json-from-string
    (first
     (multiple-value-list
      (drakma:http-request "http://www.trackip.net/ip?json" :method :get))))))

(defun whatismyipaddress ()
  "Fetch my public IP address from whatismyipaddress.com."
  (first
   (multiple-value-list
    (drakma:http-request "http://bot.whatismyipaddress.com" :method :get))))

(defun ip-api ()
  "Fetch my public IP address from ip-api.com."
  (cdr-assoc
   :query
   (json:decode-json-from-string
    (babel:octets-to-string
     (first
      (multiple-value-list
       (drakma:http-request "http://ip-api.com/json" :method :get)))))))

