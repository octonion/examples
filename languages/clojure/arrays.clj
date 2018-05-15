;clojure is a language built with immutable/persistent data structures. there is no concept of changing what a vector/list 
;is, instead clojure creates a new array with an added value using (conj...)
;in the example below the my-list does not change.
 
(def my-list (list 1 2 3 4 5))
 
my-list
; (1 2 3 4 5)
 
(first my-list)
; 1
 
(nth my-list 3)
; 4
 
(conj my-list 100) ;adding to a list always adds to the head of the list
; (100 1 2 3 4 5)
 
my-list ;it is impossible to change the list pointed to by my-list
; (1 2 3 4 5)
 
(def my-new-list (conj my-list 100))
 
my-new-list
; (100 1 2 3 4 5)
 
(cons 200 my-new-list) ;(cons makes a new list, (conj will make a new object of the same type as the one it is given
; (200 100 1 2 3 4 5)
 
(def my-vec [1 2 3 4 5 6])
 
(conj my-vec 300) ;adding to a vector always adds to the end of the vector
; [1 2 3 4 5 6 300]
