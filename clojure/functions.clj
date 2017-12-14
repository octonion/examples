(defn multiply [x y]
  (* x y))
 
(multiply 4 5)

(defn multiplyn
  ([] 1)
  ([x] x)
  ([x y] (* x y))
  ([x y & more] 
    (reduce * (* x y) more)))
 
(multiplyn 2 3 4 5)  ; 120
