import java.util.function.Function;
import java.util.Map;
import java.util.HashMap;
// import java.math.BigInteger;

public final class Memoizer {
    public static <I, O> Function<I, O> memoize(Function<I, O> f) {
	Map<I, O> lookup = new HashMap<>();
	return input -> lookup.computeIfAbsent(input, f);
    }
}
