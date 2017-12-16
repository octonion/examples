import java.util.function.Function;
import java.math.BigInteger;
    
public class Big_Factorial {

    private static final Function<Integer, BigInteger> CACHED = Memoizer.memoize(Big_Factorial::uncached);
 
    public static BigInteger big_factorial(Integer n) {
        return CACHED.apply(n);
    }
 
    private static BigInteger uncached(Integer n) {
        BigInteger result = BigInteger.valueOf(n.intValue());
        Integer m = n-1;
        while (m > 1) {
            result = result.multiply(BigInteger.valueOf(m.intValue()));
            m -= 1;
        }
        return result;
    }

    public static void main(String[] args)
    {
	for (int i = 0; i <= 40; i++) {
	    System.out.println(i+"! = "+big_factorial(i));
	}
    }
}
