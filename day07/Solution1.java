import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.function.BiFunction;
import java.util.stream.IntStream;

/*
 * Solution
 * Simulate the process.
 * The answer is the number of times the beams encounter splitters.
 *
 * For each line, we can obtain the indices of the split beams.
 * Since this happens several times, let's call each result a state.
 * For each state, we have a set of beam indices and a set of splitter indices.
 * The number of times the beams encounter splitters is the size of the intersection of those two sets.
 * The answer is the sum of these intersection sizes.
 *
 * Some higher-order functions (scan, zipWith) are not built-in in Java, so they're manually implemented.
 */

public class Solution1 {
    private static String SPLITTER = "^";

    public static void main(String[] args) {
        // read input
        List<String> inputLines = new BufferedReader(new InputStreamReader(System.in))
            .lines()
            .toList();
        assert(inputLines.size() > 0);

        // get the first beam index
        int firstBeamIndex = inputLines.get(0).indexOf("S");
        assert(firstBeamIndex != -1);

        // get splitter input lines
        List<String> splitterLines = inputLines
            .subList(1, inputLines.size())
            .stream()
            .filter(line -> line.contains(SPLITTER))
            .toList();

        // get splitter indices for each line
        List<List<Integer>> splitterIndexStates = splitterLines
            .stream()
            .map(Solution1::parseSplitterLineToIndices)
            .toList();

        // get the sizes of intersections of beam indices and splitter indices for each state
        List<List<Integer>> beamIndexStates = scan(Arrays.asList(firstBeamIndex), splitterIndexStates, Solution1::splitBeams);
        List<Integer> numIntersections = zipWith(beamIndexStates, splitterIndexStates, (b, s) -> getIntersection(b, s).size());

        // sum up the sizes of intersections
        Integer sumIntersections = numIntersections
            .stream()
            .reduce(0, Integer::sum);

        System.out.println(sumIntersections);
    }

    private static List<Integer> parseSplitterLineToIndices(String line) {
        return IntStream
            .range(0, line.length())
            .filter(i -> String.valueOf(line.charAt(i)).equals(SPLITTER))
            .boxed()
            .toList();
    }

    private static List<Integer> splitBeams(List<Integer> beamIndices, List<Integer> splitterIndices) {
        return beamIndices
            .stream()
            .flatMap(i -> splitterIndices.contains(i) ? Arrays.asList(i-1, i+1).stream() : Arrays.asList(i).stream())
            .distinct()
            .toList();
    }

    private static List<Integer> getIntersection(List<Integer> list1, List<Integer> list2) {
        Set<Integer> set2 = new HashSet<>(list2);
        return list1
            .stream()
            .filter(set2::contains)
            .toList();
    }

    // zip two lists into one with applying f (helper function)
    private static List<Integer> zipWith(List<List<Integer>> list1, List<List<Integer>> list2, BiFunction<List<Integer>, List<Integer>, Integer> f) {
        Iterator<List<Integer>> iter1 = list1.iterator();
        Iterator<List<Integer>> iter2 = list2.iterator();

        List<Integer> zipped = new ArrayList<>();
        while (iter1.hasNext() && iter2.hasNext()) {
            List<Integer> n1 = iter1.next();
            List<Integer> n2 = iter2.next();
            zipped.add(f.apply(n1, n2));
        }
        return zipped;
    }

    // apply f for each input and the accumulated result (helper function)
    private static List<List<Integer>> scan(List<Integer> initial, List<List<Integer>> inputs, BiFunction<List<Integer>, List<Integer>, List<Integer>> f) {
        List<Integer> acc = initial;

        List<List<Integer>> scanned = new ArrayList<>();
        scanned.add(acc);

        for (List<Integer> input : inputs) {
            acc = f.apply(acc, input);
            scanned.add(acc);
        }

        return scanned;
    }
}
