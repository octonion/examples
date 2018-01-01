// generate n values from the Fibonacci sequence: 0, 1, 1, 2, 3, 5, 8, 13, 21, …

iter fib(n) {          // declare an iterator named fib() taking n as its argument
  var current = 0,     // declare variables to store the current…
    next = 1;        // …and next number in the sequence

  for i in 1..n {      // loop sequentially from 1 through n
    yield current;     // yield the current value back to the callsite

    current += next;   // add the next value to the current one
    current <=> next;  // swap the two values to prepare for the next iteration
  }                    // after the n iterations, return
}

for f in fib(8) do
  writeln(f);
