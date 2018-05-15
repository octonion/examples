func fibonacci(n: Int) -> Int {
    if n < 2 {
        return n
    }
    var fibPrev = 1
    var fib = 1
    for _ in 2...n {
        (fibPrev, fib) = (fib, fib + fibPrev)
    }
    return fib
}
 
for i in 1...30 {
    print(fibonacci(n: i))
}
