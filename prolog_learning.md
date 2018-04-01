# prolog
## install
sudo apt-get install swi-prolog
## data
```
% parent(Parent, Child)
%
parent(albert, jim).
parent(albert, peter).
parent(jim, brian).
parent(john, darren).
parent(peter, lee).
parent(peter, sandra).
```
## variables
```
   ?- parent(X, brian).
Prolog replies with:

    X = jim ;
    X = pat.

    ?- parent(albert, Brian).
    Brian = jim ;
    Brian = peter.

Attention!!! variable starts with capital words
```
```
The special variable, _, can be used when the value of the variable is not important.
Is Albert a parent...

?- parent(albert, _).

Who are the parents...

?- parent(Parent, _).
```
## Conjunctions
```
We now ask, "Is Irene a grandparent of Brian?" This can be answered by finding out if Irene is the parent of someone who is the parent of Brian. Enter the following query to ask that question:

    ?- parent(irene, P), parent(P, brian).

The variable, P, represents that "someone" who is Brian's parent and Irene's child. Prolog will show all values for P, where the query is true.

    ?- parent(irene, Child), parent(Child, GrandChild).

    Child = jim
    GrandChild = brian

    Child = peter
    GrandChild = lee

    Child = peter
    GrandChild = sandra

    Child = peter
    GrandChild = james

    Child = peter
    GrandChild = kate

    Child = peter
    GrandChild = kyle

The response shows there are six sets of values where the query is true. The six grandchildren are Brian, Lee, Sandra, James, Kate and Kyle.
```
## rule
```

    One person, Grandparent, is the grandparent of another person, Grandchild, if:
        Grandparent is the parent of Child, and
        Child is the parent of Grandchild.

In Prolog this rule is written as:

    grandparent(Grandparent, Grandchild) :-
        parent(Grandparent, Child),
        parent(Child, Grandchild).

```
##     ?- consult(family).  

The consult command will force Prolog to re-read the family.pl file

## recursion
```
    descendant(Person, Descendant) :-
        parent(Person, Descendant).
    
    descendant(Person, Descendant) :-
        parent(Person, Child),
        descendant(Child, Descendant).
```
# lists
```
?- X = .(3,[4]).
swipl --traditional
```
```
    is_a_list([]).
    is_a_list(.(Head, Tail)) :-
        is_a_list(Tail).
```
1. 

Write a pattern matching predicate, head_tail(List, Head, Tail), which will extract the Headand Tail from the List.

 

Add this to the lists.pl file and test your program...

    % prolog -s lists.pl
    ... blah blah blah ...
    ?- head_tail(.(1, .(2, .(3, []))), Head, Tail).

    Head = 1,
    Tail = [2, 3].

    solution:
    head_tail(.(Head, Tail), Head, Tail).

2. 
```
% is_member(Element, List)   is Element in the List?
%
is_member(Element, .(Element, _)).       % base case
is_member(Element, .(_, Tail)) :-        % recursive case
    is_member(Element, Tail).
```

3. 
```
% cons(List1, List2, Result)
cons([], L, L).
cons([Head|Tail], L, [Head|TailResult]) :-
    cons(Tail, L, TailResult).
```