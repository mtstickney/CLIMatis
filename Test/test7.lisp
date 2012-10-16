(defparameter *z7*
    (let (top
	  (blue (clim3-layout:brick*
		 50 50
		 (clim3-graphics:opaque (clim3-color:make-color 0.0 0.0 1.0)))))
      (setf top
	    (clim3-layout:hbox*
	     (clim3-layout:pile*
	      (clim3-input:button-press
	       (lambda (zone code modifiers)
		 (declare (ignore zone code modifiers))
		 (let ((hbox-children (clim3-zone:children top)))
		   (if (= 3 (length hbox-children))
		       (format *debug-io* "blue zone already present~%")
		       (setf (clim3-zone:children top)
			     (append hbox-children (list blue)))))))
	      (clim3-layout:brick* 50 50)
	      (clim3-graphics:opaque (clim3-color:make-color 1.0 0.0 0.0)))
	     (clim3-layout:pile*
	      (clim3-input:button-press
	       (lambda (zone code modifiers)
		 (declare (ignore zone code modifiers))
		 (let ((hbox-children (clim3-zone:children top)))
		   (if (= 2 (length hbox-children))
		       (format *debug-io* "blue zone not present~%")
		       (setf (clim3-zone:children top)
			     (butlast hbox-children))))))
	      (clim3-layout:brick* 50 50)
	      (clim3-graphics:opaque (clim3-color:make-color 0.0 1.0 0.0)))))
      top))
  