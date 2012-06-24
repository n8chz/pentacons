; See http://www.math.dartmouth.edu/~carlp/PDF/paper101.pdf

; R. E. Crandall has conjectured that for any odd integer q > 3, there is a positive integer
; m whose orbit in the "qx + 1 problem" does not contain 1.  [Franco and Pomerance] show
; that this is true for almost all odd numbers q, in the sense of asymptotic density.

(defun lof (n) ; largest odd factor
 (do
  ((result n (/ result 2)))
  ((oddp result) result)))

(defun c (q m &optional (j 1)) ; q=3 for collatz, m is starting point, j is no. of iterations
 (if (oddp q)
  (do
   ((i 1 (1+ i))
    (result (lof (1+ (* q m))) (lof (1+ (* q result)))))
   ((= i j) result))))


