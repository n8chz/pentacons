; discrepancy of perfect fifth (3:2 freq. ratio) from nearest integer number of temperaments,
; where the there are ntemps temperaments to the octave.

(defun discrep (ntemps)
 (let*
  ((b (* ntemps (1- (log 3 2))))
   (c (round b)))
  (expt (- b c) 2)))

; list of temperament numbers
; which are a better fit than all lesser numbers
; see http://oeis.org/A005664

(defun scales (maxn)
 (let
  (d (mind 1) (result nil))
  (do
   ((k 1 (1+ k)))
   ((> k maxn) result)
   (setf d (discrep k))
   (if
    (< d mind)
    (progn
     (setf mind d)
     (setf result (append result (list k))))))))

