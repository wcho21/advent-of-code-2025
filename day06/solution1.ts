import assert from "node:assert";
import readline from "node:readline";

/*
 * Solution
 * Read each number in each column and get the grand total.
 */

const lines: string[][] = [];
const reducers = {
    "*": (a: number, b: number) => a * b,
    "+": (a: number, b: number) => a + b,
};

readline
    .createInterface({ input: process.stdin, output: process.stdout, terminal: false })
    .on("line", (line: string) => {
        // read input
        lines.push(line.trim().split(/\s+/));
    })
    .once("close", () => {
        // initialize
        const lastLine = lines.at(-1);
        if (lastLine === undefined) {
            throw new Error("No input lines.");
        }

        const numColumns = lastLine.length;
        let grandTotal = 0;

        // reduce each column and get the grand total
        for (let i = 0; i < numColumns; i++) {
            const operator = lastLine[i];
            if (operator !== "*" && operator !== "+") {
                throw new Error(`Bad operator ${operator}.`);
            }

            const range = Array(lines.length - 1).keys();
            const nums = range.map((j: number) => Number(lines[j][i]));
            grandTotal += nums.reduce(reducers[operator]);
        }

        console.log(grandTotal);
    });
