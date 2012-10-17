(in-package #:clim3-zone)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Generic function COMPUTE-GIVES.
;;;
;;; This function is repsonsible for computing and setting the gives
;;; of a zone.  It is only called on a zone with invalid gives.  
;;;
;;; There will be a method specialized for each atomic zone whose
;;; gives depend on the current client.  
;;;
;;; We also supply a default method specialized for COMPOUND-ZONE.
;;; That method calls ENSURE-GIVES-VALID on each child, and then calls
;;; COMBINE-CHILD-GIVES to combine the result. 
;;;
;;; After a call to this function, the gives of the zone are valid as
;;; reported by GIVES-VALID-P. 

(defgeneric compute-gives (zone))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Generic function COMBINE-CHILD-GIVES.
;;;
;;; This generic function is charged with combining the give of each
;;; child of a compound zone, and calling the functions SET-HGIVE
;;; and SET-VGIVE to set the result for the zone.
;;;
;;; This function will be called only on compound zones with gives
;;; that depend on the gives of the children.
;;;
;;; After a call to this function, the gives of the zone are valid as
;;; reported by GIVES-VALID-P.

(defgeneric combine-child-gives (compound-zone))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Function ENSURE-GIVES-VALID.
;;;
;;; This function checks whether the gives of the zone are valid, and
;;; if so does nothing.  Otherwise, it calles COMPUTE-GIVES.

(defun ensure-gives-valid (zone)
  (unless (gives-valid-p zone)
    (compute-gives zone)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Generic function IMPOSE-SIZE.
;;;
;;; This function is called in order to set the size of a zone.  

(defgeneric impose-size (zone width height))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Generic function CHILD-LAYOUTS-VALID-P.
;;;

(defgeneric child-layouts-valid-p (compound-zone))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Generic function (SETF CHILD-LAYOUTS-VALID-P).
;;;

(defgeneric (setf child-layouts-valid-p) (new-value compound-zone))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Generic function IMPOSE-CHILD-LAYOUTS.

(defgeneric impose-child-layouts (compound-zone))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Function ENSURE-CHILD-LAYOUTS-VALID.

(defun ensure-child-layouts-valid (compound-zone)
  (unless (child-layouts-valid-p compound-zone)
    (impose-child-layouts compound-zone)
    (setf (child-layouts-valid-p compound-zone) t)))