#include <assert.h>
#include <stdio.h>

/*
 * Solution
 * Just count when the dial mod 100 is equal to zero for each input line.
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

        // move the dial
        dial += (direction == 'R') ? distance : 100 - (distance % 100);
        dial %= 100;
        assert(0 <= dial && dial < 100);

        // count if any click
        if (dial == 0) {
            password++;
        }
    }

    printf("%d\n", password);
}
