import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.function.BiFunction;
import java.util.stream.IntStream;

/*
 * Solution
 * Now, we need to keep track of the number of timelines.
 * For each index, we have the number of timelines the beams belong to.
 * Create a map where the key is a beam index and the value is the timeline count.
 * By simulating the process, we can obtain the beams in the last state.
 * The answer is the sum of all timeline counts.
 */

public class Solution2 {
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
            .map(Solution2::parseSplitterLineToIndices)
            .toList();

        // get the last beams and reduce them to the total timelines
        Map<Integer, Long> lastBeams = splitterIndexStates
            .stream()
            .reduce(Map.of(firstBeamIndex, 1L), Solution2::splitBeams, Solution2::mergeMaps);
        long sumTimelines = lastBeams.values().stream().reduce(0L, Long::sum);

        System.out.println(sumTimelines);
    }

    private static Map<Integer, Long> mergeMaps(Map<Integer, Long> map1, Map<Integer, Long> map2) {
        map2.forEach((k, v) -> map1.merge(k, v, Long::sum));
        return map1;
    }

    private static List<Integer> parseSplitterLineToIndices(String line) {
        return IntStream
            .range(0, line.length())
            .filter(i -> String.valueOf(line.charAt(i)).equals(SPLITTER))
            .boxed()
            .toList();
    }

    private static Map<Integer, Long> splitBeams(Map<Integer, Long> beams, List<Integer> splitterIndices) {
        Set<Integer> splitterIndicesSet = new HashSet<>(splitterIndices);
        Map<Integer, Long> beamsSplit = new HashMap<>();

        beams.forEach((index, numTimelines) -> {
            if (splitterIndicesSet.contains(index)) {
                beamsSplit.merge(index-1, numTimelines, Long::sum);
                beamsSplit.merge(index+1, numTimelines, Long::sum);
            } else {
                beamsSplit.merge(index, numTimelines, Long::sum);
            }
        });
        return beamsSplit;
    }
}
