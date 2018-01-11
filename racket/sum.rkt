#lang racket

(define (sum lst)
  (for/fold ([s 0])
            ([i (in-list lst)])
    (+ s i)))
 
(sum '(1 2 3))
