import java.util.function.Function;

public class Factorial {

    private static final Function<Long, Long> CACHED = Memoizer.memoize(Factorial::uncached);
 
    public static long factorial(long n) {
        return CACHED.apply(n);
    }
 
    private static long uncached(long n) {
        long result = n;
        long m = n - 1;
        while (m > 1) {
            result = result * m;
            m -= 1;
        }
        return result;
    }

    public static void main(String[] args)
    {
	for (int i = 0; i <= 20; i++) {
	    System.out.println(i+"! = "+factorial(i));
	}
    }
}
