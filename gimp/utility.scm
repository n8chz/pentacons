; utility.scm

; http://geocities.ws/n8chz/utitilty.txt

; This file is ungoverned
; by the Cypherpunks' Anti-License.
; Do with it as you will.

; arithmetic primitives

(define (trunc x)
 (let
  ((a (cons-array 1 'long)))
  (aset a 0 x)
  (aref a 0)))

(define (floor x)
 (let
  ((a (trunc x)))
  (if (< a 0) (- a 1) a)))

(define (frac x)
 (- x (floor x)))

(define (div m n)
 (floor (/ m n)))

(define (mod m n)
 (- m (* n (div m n))))

; pixel graphic primitives

(define (point drawable x y)
 (color2list (cadr (gimp-drawable-get-pixel drawable x y))))

(define (pset drawable x y color)
 (gimp-drawable-set-pixel
  drawable
  x
  y
  3
  (list2color color))
; (gimp-drawable-update drawable x y 1 1)
)

(define (list2color s)
 (let*
  ((c (cons-array 3 'byte)))
  (aset c 0 (car s))
  (aset c 1 (cadr s))
  (aset c 2 (caddr s))
  c))

(define (color2list c)
 (mapcar
  (lambda (x) (if (< x 0) (+ x 256) x))
  (list (aref c 0) (aref c 1) (aref c 2))))


(define (screen w h name) ; this one actually works!
 (let*
  ((img (car (gimp-image-new w h 0)))
   (lay (car (gimp-layer-new img w h 0 name 100 0))))
  (gimp-image-add-layer img lay 0)
  (gimp-display-new img)
  (gimp-image-active-drawable img)))

; experiments

(define (zmooth dra n) ; this doesn't seem to work
 (let*
  ((k n)
   (w (car (gimp-drawable-width dra)))
   (h (car (gimp-drawable-height dra)))
   (x (+ (rand (- w 2)) 1))
   (y (+ (rand (- h 2)) 1))
   (dx (- (* 2 (rand 2)) 1))
   (dy (- (* 2 (rand 2)) 1)))
  (while (> n 0)
   (print (list x y dx dy))
   (pset dra x y
    (midcolor
     (point dra (+ x dx) (+ y dy))
     (point dra (- x dx) (- y dy))))
   (set! n (- n 1))
   (set! x (+ (rand (- w 2)) 1))
   (set! y (+ (rand (- h 2)) 1))
   (set! dx (- (* 2 (rand 2)) 1))
   (set! dy (- (* 2 (rand 2)) 1)))
  t))

(define (midcolor c1 c2)
 (mapcar (lambda (x) (div x 2)) (mapcar + c1 c2)))

(define (normo x)
 (cond
  ((< x 0) (normo (+ x 256)))
  ((> x 255) (normo (- x 256)))
  (t x)))

(define (foo dra) ; this works
 (let*
  ((w (car (gimp-drawable-width dra)))
   (h (car (gimp-drawable-height dra)))
   (x (- w 1))
   (y (- h 1))
   (r) (g) (b))
  (while (>= x 0)
   (set! y (- h 1))
   (while (>= y 0)
    (set! r (mod (* x y 0.01) 256))
    (set! g (mod (* x x y 0.01) 256))
    (set! b (mod (* x y y 0.01) 256))
    (pset dra x y (list r g b))
    (set! y (- y 1)))
   (set! x (- x 1)))
  t))

;(define (test w h) ; this is very troublesome, has very small capacity
; (let*
;  ((x (- w 1)) (y))
;  (while (>= x 0)
;   (set! y (- h 1))
;   (while (>= y 0)
;    (print (list x y))
;    (set! y (- y 1)))
;   (set! x (- x 1)))
;  t))


(define (test n)
 (let*
  ((i n))
  (while (>= i 0)
   (print i)
   (set! i (- i 1)))))
