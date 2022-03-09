:- use_rendering(chess).

reinas(N, Reinas) :-
    length(Reinas, N),
	board(Reinas, Board, 0, N, _, _),
	reinas(Board, 0, Reinas).

board([], [], N, N, _, _).
board([_|Reinas], [Col-Vars|Board], Col0, N, [_|VR], VC) :-
	Col is Col0+1,
	functor(Vars, f, N),
	constraints(N, Vars, VR, VC),
	board(Reinas, Board, Col, N, VR, [_|VC]).

constraints(0, _, _, _) :- !.
constraints(N, Row, [R|Rs], [C|Cs]) :-
	arg(N, Row, R-C),
	M is N-1,
	constraints(M, Row, Rs, Cs).

reinas([], _, []).
reinas([C|Cs], Row0, [Col|Solution]) :-
	Row is Row0+1,
	select(Col-Vars, [C|Cs], Board),
	arg(Row, Vars, Row-Row),
	reinas(Board, Row, Solution).
