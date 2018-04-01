% Program:  family.pl.solution
% Source:   Prolog
%
% Purpose:  This is the sample program for the Prolog Lab in COMP9414.
%           It is a simple Prolog program to demonstrate how prolog works.
%           See lab.html for a full description.
%
% History:  Original code by Barry Drake, adapted to SWI-Prolog by Bill Wilson


% parent(Parent, Child)
%
parent(albert, jim).
parent(albert, peter).
parent(jim, brian).
parent(john, darren).
parent(peter, lee).
parent(peter, sandra).
parent(peter, james).
parent(peter, kate).
parent(peter, kyle).
parent(brian, jenny).
parent(irene, jim).
parent(irene, peter).
parent(pat, brian).
parent(pat, darren).
parent(amanda, jenny).


% female(Person)
%
female(irene).
female(pat).
female(lee).
female(sandra).
female(jenny).
female(amanda).
female(kate).

% male(Person)
%
male(albert).
male(jim).
male(peter).
male(brian).
male(john).
male(darren).
male(james).
male(kyle).


% yearOfBirth(Person, Year).
%
yearOfBirth(irene, 1923).
yearOfBirth(pat, 1954).
yearOfBirth(lee, 1970).
yearOfBirth(sandra, 1973).
yearOfBirth(jenny, 2004).
yearOfBirth(amanda, 1979).
yearOfBirth(albert, 1926).
yearOfBirth(jim, 1949).
yearOfBirth(peter, 1945).
yearOfBirth(brian, 1974).
yearOfBirth(john, 1955).
yearOfBirth(darren, 1976).
yearOfBirth(james, 1969).
yearOfBirth(kate, 1975).
yearOfBirth(kyle, 1976).



%
% my solution 


% grandparent(Grandparent, Grandchild)
% means Grandparent is a grandparent of Grandchild
%
grandparent(Grandparent, Grandchild) :-
	parent(Grandparent, Child),
	parent(Child, Grandchild).


% older(Person1, Person2) :- Person1 is older than Person2
%
older(Person1, Person2) :-
        yearOfBirth(Person1, Year1),
        yearOfBirth(Person2, Year2),
        Year2 > Year1.

siblings(Child1, Child2) :-
        parent(Parent, Child1), parent(Parent, Child2), Child1 \== Child2.

    descendant(Person, Descendant) :-
        parent(Person, Child),
        descendant(Child, Descendant).
%
% ----------------------
%  Solutions Start Here
% ----------------------


% grandparent(Grandparent, Grandchild)
% means Grandparent is a grandparent of Grandchild
%
grandparent(Grandparent, Grandchild) :-
	parent(Grandparent, Child),
	parent(Child, Grandchild).


% older(A,B)
% means A is older than B
%
older(A,B) :- yearOfBirth(A, Y1),
              yearOfBirth(B, Y2),
              Y2 > Y1.


% siblings(A,B)
% means A and B are siblings
%
siblings(A,B) :-
    parent(X,A),       % A & B share a common parent
    parent(X,B),         %
    A \== B.             % A is different from B  (Bratko, p175)



% sibling_list(Child, Siblings)
% Siblings is a list of Childs brothers and sisters
%
sibling_list(Child, Siblings) :-
	findall(Sibling, siblings(Child, Sibling), List),
	remove_duplicates(List, Siblings).
	

% remove_duplicates(List, Result)
%
% Removes duplicate entries in a list
%
remove_duplicates([], []).

remove_duplicates([X|Rest], Result) :-
	member(X, Rest), !,
	remove_duplicates(Rest, Result).
	
remove_duplicates([X|Rest], [X|Result]) :-
	% X is not a member of Rest as
	% the above clause has a cut in it.
	remove_duplicates(Rest, Result).

	

% olderBrother(A,B)
% means A is an older brother of B
%
olderBrother(A,B) :- siblings(A, B), male(A), older(A, B).


% descendant(Person, Descendant)
% means Descendant is a descendant of Person.
%
descendant(Person, Descendant) :-
        parent(Person, Descendant).
descendant(Person, Descendant) :-
        parent(Person, Child),
        descendant(Child, Descendant).


% ancestor(Person, Ancestor)
% means Ancestor is an ancestor of Person.
%
% This is functionally equivalent to descendant(Ancestor, Person).
%
ancestor(Person, Ancestor) :-
        parent(Ancestor, Person).
ancestor(Person, Ancestor) :-
        parent(Parent, Person),
        ancestor(Parent, Ancestor).


% children(Parent, ChildList)
% ChildList is bound to a list of the children of Parent.
%
children(Parent, ChildList) :-
    findall(Child, parent(Parent,Child), ChildList).


% listCount(List, Count)
% Count is bound to the number of elements in List.
%
add(A,B):-
        B is A+1.
listCount([], 0).
listCount([_|Tail], Count) :-
    listCount(Tail, TailCount),
    add(TailCount,Count).
    %Count is TailCount + 1.


% countDescendants(Person, Count)
% Count is bound to the number of descentants of Person.
%
countDescendants(Person, Count) :-
    findall(Decendant, descendant(Person,Decendant), List),
    listCount(List, Count).


deepListCount([],0).
deepListCount(A,1) :-
        A \= [], not(A = [_|_]).
deepListCount([Head|Tail],Count) :-
        deepListCount(Tail,Count1),
        deepListCount(Head,Count2),
        Count is Count1 + Count2.
%