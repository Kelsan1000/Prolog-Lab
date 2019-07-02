
% Prolog translation of the following grammar:
%
%   <even> ::= <empty>
%           |  a a <even>
%
%   <odd> ::= a
%          |  a a <odd>
%
%   <foo> ::= <even> eo <odd>
%          |  <odd> oe <even>

% 2 cases for stmts 
% 5 cases for stmt 
% 1 case for blck 
% 1 case for legal 
% 3 cases of either member or notmember 
% should not need append 
% 2 cases for declare 
% make our own unit tests

% legal([begin,declare,x,declare,x,end],P).
% legal([begin,declare,x,end],P
% consult('lab4stage4.pl').
% legal([begin,declare,x,begin,declare,x,end,end],P).

stmt([pass|List2],List2,pass,List3,List3,Declarations,Declarations) :- !.
stmt([declare,Var|List2],List2,declare(Var),List3,[Var|List3],Declarations,[Var|Declarations]) :- member(Var,List3),atom(Var),!.
stmt([declare,Var|List2],List2,declare(Var),List3,[Var|List3],Declarations,Nesting) :- not(member(Var,Declarations)),atom(Var),!.
stmt([use,Var|List2],List2,use(Var),List3,List3,Declarations,Declarations) :- member(Var,List3),atom(Var),!.
stmt(List1,List2,P,List3,List3,Declarations,Declarations) :- blck(List1,List2,P,List3,List3,Declarations,Declarations).

stmts(List2,List2,[],List3,List3,Declarations,Declarations). 
stmts(List1,List2,[H|T],List4,Vars,Declarations,Nesting) :- stmt(List1,List3,H,List4,NewVars,Declarations,Nesting),stmts(List3,List2,T,NewVars,Vars,Declarations,Nesting).

blck([begin|List1],List2,P,List3,List3,_,_) :- stmts(List1,[end|List2],P,List3,_,Declarations,_).

legal(L,P) :- blck(L,[],P,[],[],[],[]).



