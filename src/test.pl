% ---------------------------------------------------------------------
% TESTING
%
% Runs all test cases defined automatically and displays its solution.
%
% Credits to Peng Zhou, Duc Tran and James for the test cases.
% ---------------------------------------------------------------------
test :-
    runtests(true).
silent :-
    runtests(false).
runtests(Verbose) :-
    foreach(
        testcase(Label, _, _), 
        runtest(Verbose, Label)
    ).
runtest(Verbose, Label) :- 
    testcase(Label, Puzzle, WordList),
    format('test: ~w~n', Label),
    time(findall(Puzzle, puzzle_solution(Puzzle, WordList), Solutions)),
    length(Solutions, NSolutions),
    format('solutions: ~w~n', NSolutions),
    (   Verbose
    ->  foreach(
            nth1(N, Solutions, Solution),
            (   format('solution #~w:~n', N),
                maplist(writeln, Solution)
            )
        )
    ;   true
    ).
% ---------------------------------------------------------------------
% TEST CASES

testcase(1, Puzzle, WordList) :- 
    Puzzle =   [[#,_,_,_,#,_,_,_],
                [#,#,#,_,_,_,#,#],
                [#,#,_,_,_,_,_,_],
                [#,#,_,_,_,#,_,_],
                [_,_,#,#,_,_,_,_],
                [_,_,_,_,_,#,#,_],
                [#,#,_,_,#,_,_,_],
                [_,_,_,_,_,_,_,_]
                ],
    WordList = [[c,a,r],[b,a,t],[r,e,d,e],[e,b,e],[b,e,d],[a,d,a,d,a,d],[a,t],[b,a,d,d,y],[d,d,a,d,n,e],
                [t,o],[t,w,i,n,y],[t,t],[o,w],[i,k,i],[k,o],[n,o,v],[r,u,n],[u,n,i,v,e,r,s,e],[r,r],
                [u,s],[t,e,d],[a,b,c],[b,d],[d,b,c,a]].

testcase(2, Puzzle, WordList) :-
    Puzzle =   [[_,_,_,_,#,_,_,_,_,_,#,_,_,_,_],
                [_,_,_,_,#,_,_,_,_,_,#,_,_,_,_],
                [_,_,_,_,#,_,_,_,_,_,#,_,_,_,_],
                [_,_,_,#,_,_,_,_,#,_,_,_,_,_,_],
                [#,#,_,_,_,_,_,#,_,_,_,_,#,#,#],
                [_,_,_,_,_,_,#,_,_,_,_,_,_,_,_],
                [_,_,_,_,_,#,_,_,_,_,_,#,_,_,_],
                [_,_,_,_,#,_,_,_,_,_,#,_,_,_,_],
                [_,_,_,#,_,_,_,_,_,#,_,_,_,_,_],
                [_,_,_,_,_,_,_,_,#,_,_,_,_,_,_],
                [#,#,#,_,_,_,_,#,_,_,_,_,_,#,#],
                [_,_,_,_,_,_,#,_,_,_,_,#,_,_,_],
                [_,_,_,_,#,_,_,_,_,_,#,_,_,_,_],
                [_,_,_,_,#,_,_,_,_,_,#,_,_,_,_],
                [_,_,_,_,#,_,_,_,_,_,#,_,_,_,_]],
    WordList = [[c,a,l],[f,p,c],[l,i,n],[o,d,e],[t,h,y],[u,g,h],[w,a,s],[y,e,n],
                [b,a,i,t],[c,a,m,e],[c,a,v,e],[c,h,a,d],[c,l,o,d],[c,o,s,y],[c,u,r,d],[c,y,s,t],[e,r,o,s],[f,a,t,e],[f,i,d,e],[f,r,y,e],
                [g,y,r,o],[h,a,l,e],[h,e,e,d],[i,n,d,y],[k,n,o,w],[n,o,l,l],[o,a,t,h],[p,a,r,e],[p,a,u,l],[r,a,r,e],[r,o,l,l],[r,u,d,e],
                [r,u,n,t],[s,e,w,n],[s,l,a,y],[s,p,i,t],[t,a,n,h],[t,h,e,n],[t,r,i,o],[v,o,i,d],[w,a,n,e],[w,a,s,t],[w,i,l,e],[y,a,l,e],
                [a,g,a,i,n],[a,g,o,n,e],[a,w,a,r,d],[c,a,b,l,e],[c,a,l,v,e],[c,a,r,t,e],[c,a,r,v,e],[c,h,a,f,e],[c,h,a,r,d],[c,h,u,t,e],[c,o,u,r,t],
                [c,o,v,e,t],[d,r,a,m,a],[e,l,d,e,r],[e,r,r,o,l],[e,s,t,e,r],[k,o,r,e,a],[k,r,a,f,t],[o,h,a,r,e],[r,h,o,d,a],[s,h,a,d,e],[t,a,s,t,e],
                [c,a,p,u,t,o],[c,h,i,s,e,l],[e,s,k,i,m,o],[e,v,e,l,y,n],[p,a,m,p,e,r],[p,o,n,d,e,r],[s,t,r,e,w,n],[s,t,r,i,d,e],
                [c,o,a,l,e,s,c,e],[e,n,t,e,n,d,r,e],[l,e,a,c,h,a,t,e],[o,r,d,i,n,a,t,e],[s,c,u,l,p,t,u,r,a,l],[s,t,a,n,d,p,o,i,n,t]].

testcase(3, Puzzle, WordList) :- 
    Puzzle =  [[_,_,_,_,_,_,_,#,_,_,_,_,_,_,_,#,_,_,_,_,_,_,_,_,_,_,_,_,_,#,_,_],
                [_,#,_,_,#,#,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,#,#,_,#],
                [_,_,_,_,#,_,_,_,_,#,_,#,_,_,_,_,_,_,_,#,_,_,#,_,_,_,_,_,#,_,_,#],
                [_,_,_,_,#,#,_,_,_,_,_,_,_,_,_,#,_,_,#,_,_,_,_,_,_,_,#,_,_,_,_,_],
                [_,_,#,_,_,_,_,#,_,_,_,_,_,#,#,_,_,#,_,#,#,_,_,_,_,_,_,#,_,_,_,#],
                [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,#,#,_,_,_,_,_,_,#,_],
                [_,_,_,_,_,_,_,_,_,_,_,_,_,_,#,#,_,_,_,_,_,_,_,_,_,_,_,_,#,_,_,_],
                [_,_,_,_,_,_,_,_,_,_,_,_,_,#,#,_,#,_,_,_,#,_,_,#,_,_,_,_,_,_,_,_],
                [_,#,_,_,_,_,_,_,_,_,_,_,_,_,#,_,_,_,_,_,#,_,#,_,_,_,_,_,#,_,_,_],
                [_,#,_,_,_,_,_,_,_,_,_,#,_,_,_,_,#,_,#,_,#,_,_,_,_,_,_,_,_,_,_,_],
                [_,#,_,_,_,_,_,#,#,_,#,_,_,_,_,_,_,_,#,_,#,#,_,_,_,#,_,_,_,_,_,_],
                [_,_,_,_,#,_,#,_,_,_,_,_,_,_,#,_,_,#,_,_,_,_,_,_,_,_,_,_,#,_,#,_],
                [_,_,#,_,_,_,_,_,_,_,#,_,#,_,#,_,_,_,_,#,_,_,_,_,_,#,_,_,_,#,_,#],
                [_,_,#,_,_,#,_,_,_,_,_,#,_,_,_,_,_,_,_,_,#,_,_,_,_,_,_,_,_,_,_,_],
                [_,_,_,#,_,_,_,_,_,_,_,_,_,_,#,_,_,_,_,#,#,_,_,_,_,_,#,_,_,#,#,#],
                [_,_,_,_,_,_,#,_,_,_,_,_,_,_,_,#,#,_,_,_,_,_,_,#,_,_,#,_,_,#,_,_],
                [_,#,_,#,_,_,_,_,_,_,_,#,#,_,_,_,#,#,_,_,#,_,_,#,_,#,_,_,_,_,_,_],
                [#,_,_,_,_,_,_,_,_,_,_,_,#,_,_,_,_,#,#,_,_,_,_,_,_,_,#,_,_,_,_,_],
                [_,_,#,_,_,_,_,_,_,_,#,_,_,_,_,_,#,_,#,#,_,_,_,_,_,#,#,#,_,_,_,#],
                [_,_,#,#,_,_,_,_,_,#,_,_,_,_,_,_,#,_,_,_,_,#,_,#,_,_,_,_,_,_,#,_],
                [_,#,_,_,_,#,_,_,#,_,#,_,_,_,_,_,#,_,_,_,_,_,#,_,_,_,_,_,_,_,_,_],
                [_,#,_,#,_,_,_,_,_,_,_,_,_,_,#,_,#,_,_,_,_,_,#,#,#,#,_,_,_,_,_,_],
                [#,_,_,_,#,_,#,_,_,_,_,_,_,_,_,_,_,#,_,_,_,#,_,_,_,_,#,_,#,_,_,#],
                [_,_,_,_,_,_,_,#,#,#,_,_,_,_,_,_,_,#,#,_,_,_,_,_,_,#,_,_,_,#,_,_],
                [_,_,_,_,_,#,_,_,_,_,_,_,#,_,_,#,_,_,_,_,_,_,_,_,#,#,#,_,_,_,_,_],
                [_,#,#,_,_,_,_,_,_,_,_,_,_,_,#,_,#,_,_,_,_,_,_,#,_,_,_,_,_,_,_,#],
                [_,_,#,_,_,_,_,_,_,_,_,_,_,#,_,_,_,#,#,#,_,_,_,_,_,_,_,_,#,#,#,#],
                [_,_,_,_,_,_,_,_,_,#,_,_,_,#,_,_,_,_,_,_,_,_,_,_,_,_,_,_,#,_,_,#],
                [_,#,_,_,#,_,_,_,_,_,_,_,_,_,#,_,_,_,_,_,_,_,_,_,_,_,#,_,_,_,_,_],
                [_,_,_,_,_,_,#,_,_,_,_,_,_,#,#,#,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
                [#,#,#,#,_,_,#,_,_,#,#,_,_,_,_,_,_,_,_,_,_,_,_,_,#,_,_,_,_,_,_,_],
                [#,#,_,_,_,_,#,#,#,#,#,_,_,_,_,_,_,#,_,_,_,_,_,_,_,_,_,_,_,#,_,_]],
    WordList = [[o, j, z, d, h, s, w],[m, t, g, e, j, n, v],[d, q, e, v, x, k, j, m, m, q, q, g, t], 
                [x, n],[j, v],[g, e, x, x, b, a, c, v, s, b, f, q, q, s, d, d, f, g, u, p, h, x], 
                [m, s, g, e],[e, k, m, n],[v, y, i, l, t, w, j], [c, j],[u, c, s, a, j], [n, q], 
                [t, w, q, d], [o, g, c, l, v, b, y, m, z], [v, e],[v, z, j, w, g, u, q], 
                [g, w, h, e, p], [d, j],[d, b, c, f], [o, h, g, x, v],[s, z],[b, u, y, g, f, a], 
                [i, v, k],[f, m, z, p, g, a, q, b, b, e, m, w, g, c, w, s, l, d, g, e, p, w], 
                [c, p, m, v, b, x],[c, u, z, o, c, h, d, g, m, b, f, w, b, f], 
                [l, n, f, u, o, o, i, j, m, n, s, x],[g, g, d],[f, f, b, x, a, b, r, z, h, q, p, h, w], 
                [g, n, g],[x, x],[p, b, n, a, l, p, t, f],[t, t, o, k, k, k, q, q, e, z, v, s],
                [p, a, t, t, o],[g, h, u, l, e],[d, t, q],[i, v, j, x, p, t, s, k, h],[m, q, f, i],
                [k, a, e, t, f, j, u, f, y, o, m],[d, k, k, g, s],[x, p, a, p, s, e, l],[n, c, q],
                [q, x, h, i, k, q],[n, f, a, f],[q, a, j, n, q, s, d], [e, z],[z, n, g, g, a, y, b, i, i, r],
                [y, j], [p, i, o, u, u, z, e], [x, n, s, h],[b, t, z, q, u],[e, s, z],[h, u],[h, m],
                [p, h, e, o, z], [i, m, m, j, q, b, j, r], [x, w, o, x, x, u, v, g, u, h, j],
                [q, e, d], [t, f, t, o, q, i, h, i, f, k], [t, z, e, h], [p, f, d, g, u], [w, k],
                [y, j, j, w, e, l], [u, s, k, d, q, f, m, s], [r, q, i, z, d, e], [m, n], [y, h],
                [u, z], [v, j, x, i, o, j, z], [z, z, n], [c, c], [p, y], [c, n, j, w, c, g],
                [r, b, n, a, l, k, d, w, x, d, m], [z, b, x, n], [l, x, d, d, s, a, e], [z, c, c, g, v],
                [k, a], [o, y, a, g, h, r, t], [c, t, l, w, e], [y, h, v, m, i], [l, o, y], [u, g],
                [q, z, l, c, d], [m, c, r, g, a, i], [p, z, e, a], [t, z, e, x, b, p], [t, w, p], [g, o],
                [d, f, x, m, t], [q, q, o, j, x], [s, b, o, k, o, v, n, y, o], [k, c, v, z, x, p, h, q, l, y],
                [h, e, j, q, d], [b, c, q, e, e, b], [r, y, r], [u, e, l, z, u, d, m, s, n, b], [h, l, k], [b, n, e, k], 
                [f, m], [x, x, a, s, m, u, q], [w, c, o, x, u, f, t], [n, g, q, i, m, j], [q, q, i], [l, u], [i, x, q, t, j], 
                [b, z, g, e, x, p], [j, k], [h, p, h, b, e, n, f, p], [w, y, r, c, j], [t, p, g, g, w, f, p, w, m, g, a], 
                [r, t, m, a, c, n], [m, v, w, h, y, q, z], [e, a], [e, g, t, k, m, m, y, g, p, m], [o, n, y], [e, a, p, s, b, j, v, x], 
                [z, j, h, i, h, q, i, t, h], [d, o, g], [j, y, l, w, z, p, a, g, g, c, q, m, z, f], [t, s], [i, s], 
                [n, o, x, h, l, g, s, w, l], [v, a, h, k, r, m, b, p, c, z, f], [e, t, y, z, g], [j, q, p, e, c, c], 
                [k, d, l, w, c, r], [n, z, u, w, k, d, s, p, g, r, n, q, t, d, c, y], [q, j], [o, g], [m, i, b, m, s, v, w, s, n, d, k, w, v], 
                [j, y, u, f, s, c, b], [u, b, q, m], [w, g, s, c, e, b], [n, n, j, k, t, c, m, m, x, i, m], [g, p], 
                [o, u, m, t, d, f, c, f, a, v, p, n, y, h, q, y, u], [k, u, x, y], [x, i, x, e, z, p, j], [s, w, j, m, u, f], 
                [f, j, u, e, j], [r, a, g], [r, x, x], [b, j], [z, j, g, q], [z, z, b, t, i, d, a], [d, j, v, b], [t, x, y, a, q], 
                [h, i, p], [d, v, e, d, d, p, o, x, t, v, k, f, p, h], [n, o], [r, s, t, t, e, i, s, e], [b, g, c, a, o, j, k], 
                [i, m, t, e, v, a, y, q, p, k], [m, j, p, g, h], [c, q, q], [c, a, h, b, k, x, g, q, o], 
                [f, l, j, l, a, z], [c, z, u], [g, t, q, n, c, j, m], [w, g, k, o, f, q, d, r, k, p, s], 
                [u, p, t], [x, k, g, l, g, v], [q, b, g, k, i, o], [e, m, g], [b, g, z, k, t], [q, u, h, o, u, i, d, h, c, o, z, u], 
                [z, w, m, t, x, k, o], [m, x, n, c, o, b, m, h, q, s], [a, z, e, q, s, o, w, r, d], [x, d], [g, f, m, h, h, d, g], [t, x], 
                [l, h, e, b, q, q, k, w, j, e, o, i, k, j, x, t], [q, p, l], [e, p, y], [l, l], [g, b, q, v, g, m, f, p, e, h], [z, h, d, z, d], 
                [h, z, w, x, w, g, d, g, w], [e, b], [b, x, w, w, h, z], [x, q, i], [i, q], [m, c, c, d, q, u, c, p, m, p, o, s, c, m, w], 
                [j, c, v, y, v, g, b, w, v, m, p, s], [i, f, f], [t, r, f, l, d, o], [g, m, g, w, r, i, g], [n, v, y, m], [c, f], 
                [s, q, a, d, j, m, k, m, z, z, l, g, x, y, m, x, j, a], [b, s], [v, s, i, z], [f, p], [s, z, b, w, a, m], [s, u, k], [o, j], 
                [m, c], [b, l], [s, s], [f, p, i, s, e, x, j, t], [n, x, e, i, t, u, n, f], [a, n, y, v], [s, e], [d, f, t, v, z, l, l], 
                [e, z, n, q, z], [b, t, h], [y, l, a, n, v, b], [q, q, w, e], [d, n, g, t, t, l], [s, b, e, r], [k, p, q, h], [p, r], 
                [w, h, z, w], [e, q, j], [r, g, f, n, t], [z, h, j, h, q, c], [z, q, e, h], [h, t], [z, k, u, s, n], [v, s], [e, u, g, o, l, a, n], 
                [i, c, l], [e, o, j, l, n, b, m], [p, r, w, n, n], [x, d, c, z], [p, o], [g, b], [x, y, a, j, q, k, g, e, a, e, a, m, k, d, j], 
                [k, d, j, j, b, w, o, x, m, k], [g, t, x, p, d, p, d, h], [x, e], [q, n, c, a, g, b, d, k, k], [j, f], [w, u], [i, x], 
                [a, n, a, z, w, f, e, y, d, v, h], [b, i, f, n, p, g, p, s, w, t], [m, g, u, g, y], [g, e, c, y, q, o, d], [s, m], [n, m, p], 
                [s, c, c, p, v, c], [m, u, c, u, g, c, m, p, h, t, q, b, u, x, g, m, s, a, i, t, b], [e, j], [m, b, q, z, g], 
                [q, p, s, q, f, p, n, b, u, f], [x, u, n], [z, o], [v, j, m, f, r, j, m], [q, h, a], [a, m, s, n, l, j, q, i, e, u], [e, k, b], 
                [w, v, z], [n, y, x], [g, x, j, g], [v, x, a, e, u, x, r, s, v, w, y, n, z], [x, o, c, o, q, w, h, x, f, e, q, u, i], [w, i, b], 
                [f, h], [z, g, k, h, j, c, l, b, v, q], [i, y, y], [t, t, f, m], [n, h, v, x, g, p, d, y, i, f], [w, c, o, p, n, e, f], [r, q], [t, y, d, s], 
                [x, b, q, e, k], [g, t, t, o, k], [l, h], [u, c, g, y], [y, e, m, l, c, z], [s, z, c, c, g], [i, d, f, q, m, q, w], [z, g, v], [d, o, b], [u, j], [g, y, b, p]].