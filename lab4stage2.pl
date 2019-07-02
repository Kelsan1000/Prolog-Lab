% Prolog translation of the following grammar:
%
%   <even> ::= <empty>
%           |  a a <even>
%
%   <odd> ::= a
%          |  a a <odd>
%
%   <foo> ::= <even> eo <odd>
%          |  <odd> eo <even>

stmt([pass|List2],List2,pass).
stmt([declare,Var|List2],List2,declare(Var)) :- atom(Var).
stmt([use,Var|List2],List2,use(Var)) :- atom(Var).
stmt(List1,List2,P) :- blck(List1,List2,P).

stmts(List2,List2,[]).
stmts(List1,List2,[H|T]) :- stmt(List1,List3,H),stmts(List3,List2,T).

blck([begin|List1],List2,P) :- stmts(List1,[end|List2],P).

legal(L,P) :- blck(L,[],P).