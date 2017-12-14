(defn palindrome? [s]
  (= s (apply str (reverse s))))

;; Recursive

(defn palindromer? [s]
  (loop [i 0
         j (dec (. s length))]
    (cond (>= i j) true
          (= (get s i) (get s j))
            (recur (inc i) (dec j))
          :else false)))
;; Test

(palindrome? "amanaplanacanalpanama")
;; true
(palindrome? "Test 1, 2, 3")
;; false

(palindromer? "amanaplanacanalpanama")
;; true
(palindromer? "Test 1, 2, 3")
;; false
