class Fibonacci
{
    public static long itFibN(int n)
    {
	if (n < 2)
	    return n;
	long ans = 0;
	long n1 = 0;
	long n2 = 1;
	for(n--; n > 0; n--)
	    {
		ans = n1 + n2;
		n1 = n2;
		n2 = ans;
	    }
	return ans;
    }

    /**
     * O(log(n))
     */
    public static long fib(long n) {
	if (n <= 0)
	    return 0;
 
	long i = (int) (n - 1);
	long a = 1, b = 0, c = 0, d = 1, tmp1,tmp2;
 
	while (i > 0) {
	    if (i % 2 != 0) {
		tmp1 = d * b + c * a;
		tmp2 = d * (b + a) + c * b;
		a = tmp1;
		b = tmp2;
	    }
 
	    tmp1 = (long) (Math.pow(c, 2) + Math.pow(d, 2));
	    tmp2 = d * (2 * c + d);
 
	    c = tmp1;
	    d = tmp2;
 
	    i = i / 2;
	}
	return a + b;
    }

    public static long recFibN(final int n)
    {
	return (n < 2) ? n : recFibN(n - 1) + recFibN(n - 2);
    }

    public static long fibTailRec(final int n)
    {
	return fibInner(0, 1, n);
    }
 
    private static long fibInner(final long a, final long b, final int n)
    {
	return n < 1 ? a : n == 1 ?  b : fibInner(b, a + b, n - 1);
    }

    public static long anFibN(final long n)
    {
	double p = (1 + Math.sqrt(5)) / 2;
	double q = 1 / p;
	return (long) ((Math.pow(p, n) + Math.pow(q, n)) / Math.sqrt(5));
    }
    
    public static void main(String[] args)
    {
	System.out.print("itFibN: ");
	for (int n = 2; n <= 20; n++)
	    {
		long value = itFibN(n);
		System.out.print(" " + value);
	    }
	System.out.println();

	System.out.print("recFibN: ");
	for (int n = 2; n <= 20; n++)
	    {
		long value = recFibN(n);
		System.out.print(" " + value);
	    }
	System.out.println();

	System.out.print("anFibN: ");
	for (int n = 2; n <= 20; n++)
	    {
		long value = anFibN(n);
		System.out.print(" " + value);
	    }
	System.out.println();

    }
}
