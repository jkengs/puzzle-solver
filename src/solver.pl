:- use_module(library(clpfd)).
:- use_module(library(pairs)).
:- use_module(library(apply)).
:- use_module(library(lists)).

% ---------------------------------------------------------------------
% DESCRIPTION
%
% Fill-in Puzzle Solver: A solver built in prolog that takes a fill-in puzzle and the corresponding
% word list, and holds if the puzzle is solvable (fillable with all the words).
%
% ---------------------------------------------------------------------
% LIBRARIES USAGE
%
% transpose/2 from 'clpfd'.
%
% map_list_to_pairs/3, group_pairs_by_key/3, pairs_keys_values/3, pairs_values/2 from 'pairs'.
%
% include/3 and exclude/3 from 'apply'.
%
% member/2 and append/3 from 'lists'.
%
% ---------------------------------------------------------------------
% PROGRAM

% puzzle_solution(+Puzzle, +WordList)
%
% puzzle_solution/2 holds when a given Puzzle is able to be solved with the given
% WordList, where all the empty grids are able to be filled using all of the  words.
%
% Steps:
% 1. First, all horizontals slots (i.e., sequence of fill-able and pre-filled squares) are extracted
%   out from the puzzle.
% 2. The puzzle is then transposed to create TPuzzle where the vertical slots are extracted out.
% 3. The extracted slots are then filtered to slots that are fillable and valid (i.e., remove n-word
%   slots if there are no n-letter words in the list).
% 4. The filtered slots are then sorted according to the number of matching words, from
%   the least to the most.
% 5. The slots are then unified with the words.
puzzle_solution(Puzzle, WordList) :-
    process_puzzle(Puzzle, Slots),
    solve_puzzle(Slots, WordList).

% ---------------------------------------------------------------------

% ---------------------------------------------------------------------
% PROCESS PUZZLE (STEPS 1 AND 2)

% process_puzzle(+Puzzle, -Slots)
%
% process_puzzle/2 extracts the horizontal and vertical slots from the given Puzzle (and its 
% transposed self, TPuzzle), where they are combined into one list (output).
process_puzzle(Puzzle, Slots) :-
    extract_slots(Puzzle, [], HSlots),
    transpose(Puzzle, TPuzzle),
    extract_slots(TPuzzle, [], VSlots),
    append(HSlots, VSlots, Slots).

% extract_slots(+Puzzle, +Acc, -RowSlots)
%
% extract_slots/3 takes a Puzzle and an accumulator (an empty list at initialization), where it
% extracts the slots row by row and outputs all the slots from the puzzle.
extract_slots([], X, X).
extract_slots([Row|Rows], Acc, AllSlots) :-
    extract_row_slot(Row, [], RowSlots, []),
    append(RowSlots, Acc, Acc1),
    extract_slots(Rows, Acc1, AllSlots).

% extract_row_slot(+Row, +Acc, -RowSlots, +Buffer)
%
% extract_row_slot/4 takes in a row of characters from a Puzzle and outputs the slots from the row. 
% The accumulator will only hold a single slot at a time, while the buffer holds all the slots from 
% the row.
extract_row_slot([], [], RowSlots, RowSlots).
extract_row_slot([], Slot, [Slot|Buffer], Buffer) :- % Row ends with valid character (not '#')
    length(Slot, X), X>0.
extract_row_slot([C|Cs], Acc, RowSlots, Buffer) :-
    (   ((C \= '#') ; var(C)) ->
        % If not solid block or is a variable (underscore)
        append(Acc, [C], Acc1),
        extract_row_slot(Cs, Acc1, RowSlots, Buffer)

    ;   (length(Acc, X), X > 0) ->
        % If solid block, check for slot in accumulator and add to buffer if present
        Buffer1 = [Acc|Buffer],
        extract_row_slot(Cs, [], RowSlots, Buffer1)

    ;   extract_row_slot(Cs,[], RowSlots, Buffer)
    ).

% ---------------------------------------------------------------------

% ---------------------------------------------------------------------
% SOLVE PUZZLE (STEPS 3 TO 5)

% solve_puzzle(+Slots, +WordList)
%
% solve_puzzle/2 holds if all the words are able to be unified with all of the slots. A Key-Value
% list is first created where the slots and wordlist are paired with their length. This list will
% be used to filter for valid slots and sort them by the number of matching words they have, before
% trying to unify them.
solve_puzzle(Slots, WordList) :-
    map_list_length(Slots, MSlots), 
    map_list_length(WordList, MWordList), 
    process_slots(MSlots, MWordList, FilterSlots),
    sort_slots(MWordList, FilterSlots, SortedSlots,[]),
    match(SortedSlots, WordList).

% map_list_length(+List, -MappedList)
%
% map_list_length/2 takes in a list, maps each element of the list to their length and outputs the 
% mapped list of length-value pairs.
map_list_length(List, MappedList) :-
    map_list_to_pairs(length, List, MappedList).

% process_slots(+Slots, + WordList, -FilterSlots)
%
% process_slots/3 takes in the mapped (to length) slots and wordlist, filters the slots for only
% valid ones and outputs the resulting slots. The wordlist is first grouped according to their length 
% (i.e. n-length words are grouped in a key value pair, where the length is the key and the words 
% are the values). This grouped wordlist will be used to filter out the unfillable slots that do 
% not have a valid length (i.e. remove n-length slots if there are no n-length words).
process_slots(MSlots, MWordList, FilterSlots) :-
    group_pairs_by_key(MWordList, GWordList), 
    filter_slots(MSlots, GWordList, FilterSlots,[]). 

% filter_slots(+MSlots, +GWordList, -FilterSlots, +Acc)
%
% filter_slots/4 takes in a list of mapped (to length) slots and wordlist. Slots that have the same 
% length as any of the possible word length from the wordlist will be filtered for. The filtered 
% slots list will then have their mapped length key removed (using pairs_value from 'pairs'.
filter_slots(_, [], Filter, Acc) :- pairs_values(Acc, Filter). 
filter_slots(MSlots, [Word|Rest], Filter, Acc) :-
    get_length([Word], Length), 
    include(is_same(Length), MSlots, MatchedSlots),
    include(not_ground, MatchedSlots, MatchedSlots1),
    append(MatchedSlots1, Acc, Acc1),
    filter_slots(MSlots, Rest, Filter, Acc1). 

% get_length(+Pair, -ListLength)
%
% get_length/2 takes in a key value pair (where length is the key) and returns the length (key). It 
% uses pairs_keys_values from 'pairs' which can query for the key and value separately.
get_length(Pair, ListLength) :-
    pairs_keys_values(Pair, ListLength, _).

% is_same(+Length, +Pair)
%
% is_same/2 takes in a length value and a mapped list (to length), and holds if the length (key) of
% the mapped list is equals to the length, L.
is_same(Length,Pair) :-
    pairs_keys_values([Pair], PairLength, _), PairLength == Length.

% not_ground(+Slot)
%
% not_ground/1 holds when the slot is not ground.
not_ground(Slot) :- not(ground(Slot)).

% sort_slots(+MWordList, +FilterSlots, -SortedSlots, +Acc)
%
% sort_slots/4 takes in a mapped word list (to length), a list of filtered slots. Each slot is then 
% mapped to the number of possible matching words they have to reduce search space. The mapped slot
% are added to a list and sorted from the fewest to the most matching words, before having their 
% keys (no. of matches) removed with pairs_values from 'pairs'.
sort_slots(_,[], SortedSlots, Acc) :- sort(Acc,Acc1), pairs_values(Acc1, SortedSlots).
sort_slots(MWordList, [Slot|Rest], SortedSlots, Acc) :-
    possible_matches(MWordList, Slot, Pair),
    append(Pair, Acc, Acc1),
    sort_slots(MWordList, Rest, SortedSlots, Acc1).

% possible_matches(+MWordList, +Slot, -Pair)
%
% possible_matches/3 takes in a mapped word list (to length) and a slot, and outputs a key value
% pair, where the key is the number of possible matches the slot has and the key is the slot.
possible_matches(MWordList, Slot, Pair) :-
    length(Slot, Length),
    include(is_same([Length]), MWordList, Matches),
    length(Matches, MatchesNo),
    pairs_keys_values(Pair, [MatchesNo], [Slot]).

% match(+SortedSlots, +WordList)
%
% match/2 holds if the sorted slots are able to be unified with all the words from the list.
match([],[]).
match([Slot|Rest], WordList) :-
    member(Word, WordList),
    Slot = Word,
    exclude(==(Word), WordList, WordsLeft),
    match(Rest, WordsLeft).
% ---------------------------------------------------------------------