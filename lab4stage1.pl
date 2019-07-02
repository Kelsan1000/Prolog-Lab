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

stmt([pass|List2],List2).
stmt([declare,Var|List2],List2) :- atom(Var).
stmt([use,Var|List2],List2) :- atom(Var).
stmt(List1,List2) :- blck(List1,List2).

stmts(List2,List2).
stmts(List1,List2) :- stmt(List1,List3),stmts(List3,List2).

blck([begin|List1],List2) :- stmts(List1,[end|List2]).

legal(L) :- blck(L,[]).