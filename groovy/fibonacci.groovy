// Recursive

def rFib
rFib = { 
    it == 0   ? 0 
    : it == 1 ? 1 
    : it > 1  ? rFib(it-1) + rFib(it-2)
    /*it < 0*/: rFib(it+2) - rFib(it+1)
 
}

// Iterative
def iFib = { 
    it == 0   ? 0 
    : it == 1 ? 1 
    : it > 1  ? (2..it).inject([0,1]){i, j -> [i[1], i[0]+i[1]]}[1]
    /*it < 0*/: (-1..it).inject([0,1]){i, j -> [i[1]-i[0], i[0]]}[0]
}

// Analytic

final φ = (1 + 5**(1/2))/2
def aFib = { (φ**it - (-φ)**(-it))/(5**(1/2)) as BigInteger }

// Test program:

def time = { Closure c ->
    def start = System.currentTimeMillis()
    def result = c()
    def elapsedMS = (System.currentTimeMillis() - start)/1000
    printf '(%6.4fs elapsed)', elapsedMS
    result
}
 
print "  F(n)      elapsed time   "; (-10..10).each { printf ' %3d', it }; println()
print "--------- -----------------"; (-10..10).each { print ' ---' }; println()
[recursive:rFib, iterative:iFib, analytic:aFib].each { name, fib ->
    printf "%9s ", name
    def fibList = time { (-10..10).collect {fib(it)} }
    fibList.each { printf ' %3d', it }
    println()
}
