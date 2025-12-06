import assert from "node:assert";
import readline from "node:readline";

/*
 * Solution
 * Read each number in each column and get the grand total.
 * For each column, read numbers vertically.
 */

type ColumnPosition = [BeginIndex, EndIndex];
type BeginIndex = number;
type EndIndex = number;

const lines: string[] = [];
const reducers = {
    "*": (a: number, b: number) => a * b,
    "+": (a: number, b: number) => a + b,
};

readline
    .createInterface({ input: process.stdin, output: process.stdout, terminal: false })
    .on("line", (line: string) => {
        // read input
        lines.push(line);
    })
    .once("close", () => {
        // initialize
        const lastLine = lines.at(-1);
        if (lastLine === undefined) {
            throw Error("No input lines.");
        }

        // reduce each column and get the grand total
        let grandTotal = 0;
        const columnPositions = getColumnPositions(lines);
        for (const [beginIndex, endIndex] of columnPositions) {
            const operator = lastLine[beginIndex];
            if (operator !== "*" && operator !== "+") {
                throw Error(`Bad operator ${operator}.`);
            }

            const range = Array(endIndex - beginIndex + 1).keys().map((j: number) => j + beginIndex);
            const nums = range.map((j: number) => readNumber(j, lines));
            grandTotal += nums.reduce(reducers[operator]);
        }

        console.log(grandTotal);
    });

function getColumnPositions(lines: string[]): ColumnPosition[] {
    const lastLine = lines.at(-1);
    if (lastLine === undefined) {
        throw new Error("No input lines.");
    }

    // read the beginning indices which are determined the operator signs at the last line
    const columnBeginIndices: number[] = [];
    const length = lastLine.length;
    for (let i = 0; i < length; i++) {
        if (lastLine[i] !== ' ') {
            columnBeginIndices.push(i);
        }
    }

    // get the ending indices from the next beginning indices and make a list of pairs of the indices
    const columnPositions: ColumnPosition[] = [];
    for (let i = 0; i < columnBeginIndices.length - 1; i++) {
        columnPositions.push([columnBeginIndices[i], columnBeginIndices[i + 1] - 2]);
    }
    columnPositions.push([columnBeginIndices[columnBeginIndices.length - 1], length - 1]);

    return columnPositions;
}

function readNumber(index: number, lines: string[]): number {
    let numString: string = "";
    for (let i = 0; i < lines.length - 1; i++) {
        if (lines[i][index] == " ") {
            continue;
        }
        numString += lines[i][index];
    }
    return Number(numString);
}
