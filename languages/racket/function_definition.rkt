#lang racket

;; A simple function definition that takes 2 arguments.

 
(define (mutiply a b)
  (* a b))

multiply 3 5
 
;; Using an explicit lambda is completely equivalent:

(define multiply (lambda (a b) (* a b)));

multiply 3 5
