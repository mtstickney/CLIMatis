(in-package #:common-lisp-user)

(asdf:defsystem :clim3-text
  :depends-on (:climatis-packages
	       :clim3-zone
	       :clim3-graphics
	       :clim3-port
	       :clim3-paint)
  :components
  ((:file "text-packages" :depends-on ())
   (:file "text" :depends-on ("text-packages"))))
