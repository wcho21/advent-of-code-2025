#include <assert.h>
#include <math.h>
#include <stdio.h>

/*
 * Solution
 * Suppose that we have the dial that points to `init` and the input line is given by `R30`.
 * We can think of the problem as we've rotated right the dial from zero by `init`.
 * The number of clicks is then simply `(init+30)/100`.
 * On the other hand, if the input is given by `L30`, replace `init` with `(100 - init) % 100`.
 * This assumes that we've rotated left the dial by that amount.
 */

int main(void) {
    char *line = NULL;
    size_t len = 0;

    int dial = 50;
    int password = 0;

    while (getline(&line, &len, stdin) != -1) {
        // read input
        char direction = 0;
        int distance = 0;
        sscanf(line, "%c%d", &direction, &distance);
        assert(direction == 'L' || direction == 'R');
        assert(distance >= 1);

        // count the clicks
        int init = (direction == 'R') ? dial : (100 - dial) % 100;
        password += (init + distance) / 100;

        // move the dial
        dial += (direction == 'R') ? distance : 100 - (distance % 100);
        dial %= 100;
        assert(0 <= dial && dial < 100);
    }

    printf("%d\n", password);
}
