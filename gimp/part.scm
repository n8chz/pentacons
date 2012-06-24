; part.scm

; This file is ungoverned by the
; Cypherpunks' Anti-License.
; Do with it as you will.

; This file is in the language SIOD
; (Scheme In One Defun)
; which is used
; as a scripting language
; for a nifty bitmap engine
; known as "the Gimp."

; It is supposed to generate
; a 2-color bitmap
; in which each pixel
; represents the parity
; of the partition function
; or number of ways of
; expressing a natural number
; (given by the pixel column)
; as the sum of naturals
; restricted by a floor
; (which is the pixel row number)
; on the size of addends.

; A bitmap of this form
; is available
; (also ungoverned by the CAL,
; of course)
; at the following address:

; http://geocities.ws/n8chz/part.jpg

(load "utility.scm")

; http://geocities.ws/n8chz/utility.txt

;(define (part dra)
; (let*
;  ((w (car (gimp-drawable-width dra)))
;   (h (car (gimp-drawable-height dra)))
;   (n 1)
;   (one '(0 0 0))
;   (zero '(255 255 255)))
;  (while (< n h)
;   (set! k n)
;   (while (> k 0)
;    (cond
;     ((> k n) (pset dra k n zero))
;     ((> (* 2 k) n) (pset dra k n one))
;     (t (pset dra k n
;      (if
;       (= (car (point dra (+ 1 k) n)) (car (point dra k (- n k))))
;       zero
;       one))))
;    (set! k (- k 1)))
;   (set! n (+ n 1))))
; t)

(define (p k n)
 (cond
  ((> k n) 0)
  ((> (* 2 k) n) 1)
  ((> (* 3 k) n) (+ (div n 2) (- k) 2))
  (t (+
   (p (+ k 1) n)
   (p k (- n k))))))

(define (part size)
 (let*
  ((d (car (screen (+ 1 (div size 3)) size "")))
   (w (car (gimp-drawable-width d)))
   (h (car (gimp-drawable-height d)))
   (n 1)
   (k))
  (while (< n h)
   (set! k (- w 1))
   (while (> k 0)
    (cond
     ((> k n) (pset d k n (f 0)))
     ((> (* 2 k) n) (pset d k n (f 1)))
     ((> (* 3 k) n) (pset d k n (f (+ (div n 2) (- k) 2))))
     (t (pset d k n (f
      (+
       (invf (point d (+ k 1) n))
       (invf (point d k (- n k))))))))
    (set! k (- k 1)))
   (set! n (+ n 1)))))

(define (f n) (set! n (* 255 (mod n 2))) (list n n n))

(define (invf c) (if (= (car c) 0) 0 255))

