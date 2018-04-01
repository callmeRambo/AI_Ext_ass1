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
        parent(Person, Descendant).
descendant(Person, Descendant) :-
        parent(Person, Child),
        descendant(Child, Descendant).

ancestor(Ancestor, Person) :-
        parent(Ancestor, Person).
ancestor(Ancestor, Person) :-
        parent(Ancestor2, Person),
        ancestor( Ancestor, Ancestor2).

test(f(A, B, C), D) :-
                A = B, C = D.




is_a_list([]).
is_a_list(.(Head, Tail)) :-
    is_a_list(Tail).

head_tail(List, Head, Tail) :-
        List = .(Head, Tail).

is_member(Element, list(Element, _)).
is_member(Element, list(_,List)) :-
        is_member(Element, list(List)).

cons([],L,L).
cons([Head|Tail],L2,[Head|Tail1]) :-
        cons(Tail,L2,Tail1).
cons2([],[],[]).
cons2([Head|Tail],[Head2|Tail2],[Head+Head2|Tail3]) :-
        cons2(Tail,Tail2,Tail3).

sibling_list(Child1, D):-
        findall(D, siblings(Child1,D), List),remove_duplicates(List, Siblings).

listCount([], 0).
listCount([Head|Tail], Count):-
                listCount(Tail, Tailcount), Count is Tailcount +1.

        deepListCount(A, 1) :-
                        A \= [], not(A = [_|_]).         % A is not a list
        deepListCount([Head|Tail], Count) :-
                        deepListCount(Head,Count1),
                        deepListCount(Tail, Count2),
                        Count is Count1 +Count2.