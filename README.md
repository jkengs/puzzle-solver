# Puzzle Solver
A solver built in prolog that takes a [fill-in puzzle](https://en.wikipedia.org/wiki/Fill-In_(puzzle)) and the corresponding word list, and holds if the puzzle is solvable (fillable with all the words).

## Example
### Puzzle
| # | h | # |
|---|---|---|
| _  | _  |  _ |
| # |  _ | # |

WordList: ```hat```, ```bag```

### Solution

| # | h | # |
|---|---|---|
| b | a | g |
| # | t | # |

## Usage
```
Puzzle = <puzzle>, WordList = <wordlist>, puzzle_solution(Puzzle, WordList).
```
