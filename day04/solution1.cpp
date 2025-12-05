#include <cassert>
#include <iostream>
#include <string>
#include <vector>

/*
 * Solution
 * Count the accessible rolls of paper for each coordinate in the given diagram.
 */

using namespace std;

const pair<int, int> DS[] = { {1, 1}, {1, 0}, {1, -1}, {0, 1}, {0, -1}, {-1, 1}, {-1, 0}, {-1, -1} };

bool is_accessible(const int y, const int x, const vector<string>& diagram);

int main(void) {
    string line;
    vector<string> diagram;

    // read input
    while (getline(cin, line)) {
        diagram.emplace_back(line);
    }

    // count
    int num_accessible = 0;
    for (size_t y = 0; y < diagram.size(); y++) {
        for (size_t x = 0; x < diagram[0].size(); x++) {
            if (diagram[y][x] == '@' && is_accessible(y, x, diagram)) {
                num_accessible++;
            }
        }
    }
    cout << num_accessible << '\n';
}

bool is_accessible(const int y, const int x, const vector<string>& diagram) {
    assert(diagram.size() != 0);

    const int x_lim = diagram[0].size();
    const int y_lim = diagram.size();
    assert(0 <= y && y < y_lim);
    assert(0 <= x && x < x_lim);

    int num_papers = 0;
    for (const auto& [dy, dx] : DS) {
        const int ny = y + dy;
        const int nx = x + dx;

        if (ny < 0 || ny >= y_lim) {
            continue;
        }
        if (nx < 0 || nx >= x_lim) {
            continue;
        }
        if (diagram[ny][nx] != '@') {
            continue;
        }

        num_papers++;
    }

    return num_papers < 4;
}
