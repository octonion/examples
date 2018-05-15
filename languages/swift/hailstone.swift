func hailstone(n:Int) -> [Int] {
 
    var arr = [n]
    var m = n
 
    while m != 1 {
 
        if m % 2 == 0 {
            m /= 2
        } else {
            m = (3 * m) + 1
        }    
 
        arr.append(m)
    }
 
    return arr
}
 
let n = hailstone(n: 27)
 
print("hailstone(27): \(n[0...3]) ... \(n[n.count-4...n.count-1]) for a count of \(n.count).")
 
var longest = (n: 1, len: 1)
 
for i in 1...100_000 {
 
    let new = hailstone(n: i)
 
    if new.count > longest.len {
        longest = (i, new.count)
    }
}
 
print("Longest sequence for numbers under 100,000 is with \(longest.n). Which has \(longest.len) items.")
