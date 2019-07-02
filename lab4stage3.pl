
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

stmt([pass|List2],List2,pass,List3,List3).
stmt([declare,Var|List2],List2,declare(Var),List3,[Var|List3]) :- atom(Var),!.
stmt([use,Var|List2],List2,use(Var),List3,List3) :- member(Var,List3),atom(Var).
stmt(List1,List2,P,List3,List3) :- blck(List1,List2,P,List3,List3).

stmts(List2,List2,[],List3,List3).
stmts(List1,List2,[H|T],List4,Vars) :- stmt(List1,List3,H,List4,Vars),stmts(List3,List2,T,Vars,_).

blck([begin|List1],List2,P,List3,List3) :- stmts(List1,[end|List2],P,List3,_).

legal(L,P) :- blck(L,[],P,[],[]).