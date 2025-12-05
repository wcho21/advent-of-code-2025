#include <cassert>
#include <iostream>
#include <string>
#include <vector>

/*
 * Solution
 * Simulate the process.
 * Remove the accessible rolls of papers until there's nothing to remove.
 */

using namespace std;

const pair<int, int> DS[] = { {1, 1}, {1, 0}, {1, -1}, {0, 1}, {0, -1}, {-1, 1}, {-1, 0}, {-1, -1} };

bool is_accessible(const int y, const int x, const vector<string>& diagram);

int main(void) {
    string line;
    vector<string> diagram;

    // read input
    while (getline(cin, line)) {
        diagram.push_back(line);
    }

    // count
    int num_removed = 0;
    while (true) {
        // get the coordinates of accessible rolls of paper
        vector<pair<int, int>> coords_accessible;
        for (size_t y = 0; y < diagram.size(); y++) {
            for (size_t x = 0; x < diagram[0].size(); x++) {
                if (diagram[y][x] == '@' && is_accessible(y, x, diagram)) {
                    coords_accessible.emplace_back(y, x);
                }
            }
        }

        // end loop if no such rolls of paper
        if (coords_accessible.size() == 0) {
            break;
        }

        // count and update the diagram
        num_removed += coords_accessible.size();
        for (const auto& [y, x] : coords_accessible) {
            diagram[y][x] = '.';
        }
    }
    cout << num_removed << '\n';
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
