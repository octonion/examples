(let loop ((times 10))
   (if (= times 0)
     (display "stopped")
     (begin (display "still looping...")
            (loop (- times 1)))))