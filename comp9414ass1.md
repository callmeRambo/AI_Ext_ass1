```
COMP3411/9414/9814 Artificial Intelligence
Session 1, 2018
Assignment 1 - Prolog Programming

Due: Friday 6 April, 11:59pm
Marks: 12% of final assessment for COMP3411/9414/9814 Artificial Intelligence
Specification
In this assignment, you are to write Prolog procedures to perform some list and tree operations. The aim of the assignment is to give you experience with typical Prolog programming techniques.

At the start of your program, place a comment containing your full name, student number and assignment name. You may add additional information like the date the program was completed, etc. if you wish.

At the start of each Prolog predicate that you write, write a comment describing the overall function of the predicate.

Advice on the use of comments and meaningful identifiers in Prolog can be found under comments in the Prolog Dictionary.
Testing Your Code

A significant part of completing this assignment will be testing the code you write to make sure that it works correctly. To do this, you will need to design test cases that exercise every part of the code.

You should pay particular attention to "boundary cases", that is, what happens when the data you are testing with is very small, or in some way special. For example:

    What happens when the list you input has no members, or only one member?
    Does you code work for lists with both even and odd numbers of members?
    Does your code work for negative numbers? 

Note: not all of these matter in all cases, so for example with sqrt_table, negative numbers don't have square roots, so it doesn't make sense to ask whether your code works with negative numbers.

With each question, some example test data are provided to clarify what the code is intended to do. You need to design further test data. Testing, and designing test cases, is part of the total programming task.

It is important to use exactly the names given below for your predicates, otherwise the automated testing procedure will not be able to find your predicates and you will lose marks. Even the capitalisation of your predicate names must be as given below. 
```
# 1

Write a predicate sumsq_neg(Numbers, Sum) that sums the squares of only the negative numbers in a list of numbers. Example:
``` prolog
    ?- sumsq_neg([1,-3,-5,2,6,8,-2], Sum).
    Sum = 38
```
    This example computes (-3)*(-3) + (-5)*(-5) + (-2)*(-2). Think carefully about how the predicate should behave on the empty list — should it fail or is there a reasonable value that Sum can be bound to?

```
```prolog

sumsq_neg([], 0).
sumsq_neg([Head|Tail], Count) :-
    Head>=0,sumsq_neg(Tail, Count).    
sumsq_neg([Head|Tail], Count) :-
    sumsq_neg(Tail, TailCount),
    Head<0,Count is TailCount + Head*Head.
```

# 2
For the purposes of the examples in this question, assume that the following facts have been loaded into Prolog:
```prolog
    likes(mary, apple).
    likes(mary, pear).
    likes(mary, grapes).
    likes(tim, mango).
    likes(tim, apple).
    likes(jane, apple).
    likes(jane, mango).
```
NOTE: do not include these in your solution file.

Write a predicate all_like_all(Who_List, What_List) that takes a list of people Who_List and a list of items What_List and succeeds if every person in Who_List likes every item in What_List, according to the predicate likes(Who, What). Your predicate should also succeed if either Who_List or What_List is empty. Examples:
``` prolog
    ?- all_like_all([jane,tim],[apple,mango]).
    true

    ?- all_like_all([mary,tim],[apple,grapes]).
    false.

    ?- all_like_all([],[bananas]).
    true
```
Note that your all_like_all predicate will be tested with different likes(Who, What) facts to those in the examples.


```prolog
% likes(mary, apple).
% likes(mary, pear).
% likes(mary, grapes).
% likes(tim, mango).
% likes(tim, apple).
% likes(jane, apple).
% likes(jane, mango).
% two random person like nothing.
all_like_all([_,_],[]).
% one random person like nothing.
all_like_all([_],[]).
% nobody likes everything.
all_like_all([],_).
all_like_all([A,B],[Head|Tail]):-
        likes(A,Head),likes(B,Head),all_like_all([A,B],Tail).
% what if one person? 
all_like_all([A],[Head|Tail]):-
        likes(A,Head),all_like_all([A],Tail).
```

# 3.
Write a predicate sqrt_table(N, M, Result) that binds Result to the list of pairs consisting of a number and its square root, from N down to M, where N and M are non-negative integers, and N >= M. For example: 

```prolog
    sqrt_table(7, 4, Result).
Result = [[7, 2.6457513110645907], [6, 2.449489742783178], [5, 2.23606797749979], [4, 2.0]]

?- sqrt_table(7, 8, Result).
false.

```
 Note that the Prolog built-in function sqrt computes square roots, and needs to be evaluated using is to actually compute the square root: 
 ```prolog
?- X is sqrt(2).
X = 1.4142135623730951.

?- X = sqrt(2).
X = sqrt(2).
 ```

 ```prolog
comb(A,B,Res):-
    Res = [A,B].
sqrt_1(A,Result):-    
    X is sqrt(A),Result = [A,X]. 
dec(A,Res):-
    Res is A -1.

sqrt_2(A,B,Result):-
        A>=B,sqrt_1(A,Result).
sqrt_2(A,B,Result):-
        A>=B,dec(A,Res),sqrt_2(Res,B,Result).
    %sqrt_2(A,B,Result),
    
% sqrt_1(A,B,Result):-
%     A>B, sqrt_1(A-1,B,sqrt(A)).
sqrt_table(A,B, Result):-
    findall(X, sqrt_2(A,B, X), Result).
 ```
 <br>Write a predicate chop_up(List, NewList) that takes List and binds NewList to List with all sequences of successive increasing whole numbers replaced by a two-item list containing only the first and last number in the sequence. An example of successive increasing whole numbers is: 19,20,21,22. (Note that the numbers have to be successive in the sense of increasing by exactly 1 at each step.) For example:
```prolog
?- chop_up([9,10,5,6,7,3,1], Result).
Result = [[9, 10], [5, 7], 3, 1]

?- chop_up([1,3,2,3,4], Result).
Result = [1, 3, [2, 4]]

% 4.takes List and binds NewList to List with all sequences of successive increasing whole numbers
cons([],L,L).
cons([Head|Tail],L2,[Head|Tail1]) :-
        cons(Tail,L2,Tail1).
% combines two numbers. If reaches tail, need to consider should combine or not.

% con1: reaching tail, last number is continous
cons2(L1,L2,Head,[],Result):-
    L1 \= L2, L2 = Head, 
    Result = [[L1,L2]].
% con2: reaching tail, last list is 2 elements.last number is not continous
cons2(L1,L2,Head,[],Result):-
    L1 \= L2, L2 \= Head, 
    Result = [[L1,L2],Head].
% con3: reaching tail, last list is 1 elements.last number is not continous
cons2(L1,L2,Head,[],Result):-
    L1 = L2, 
    Result = [L1,Head].

% con4: not reaching tail.last number is continous
cons2(L1,Head,Head,Tail,Result):-
    Tail \= [],
    Result = [[L1,Head]].
% con5: not reaching tail, last list is 1 elements.last number not continous
cons2(L1,L2,Head,Tail,Result):-
    Tail \= [],
    L1 = L2,
    L2 \= Head,
    Result = [L1].
% con6: not reaching tail, last list is 2 elements.last number not continous
cons2(L1,L2,Head,Tail,Result):-
    Tail \= [],
    L1 \= L2,
    L2 \= Head,
    Result = [[L1,L2]].

% condition1: input an empty list     
chop_up2([],_,_,[]).
% condition2: haven't reached end of list(empty tail) and continous
chop_up2([Head|Tail],Start,End,Result):-
    T is End+1,
    Head = T,
    Tail\= [],
    chop_up2(Tail,Start,Head,Result2), 
    Result = Result2.
% condition3: have reached end of list(empty tail) and continous
chop_up2([Head|Tail],Start,End,Result):-
    T is End+1,
    Head = T,
    Tail = [],
    cons2(Start,Head,Head,Tail,R),
    chop_up2(Tail,Head,Head,Result2),
    cons(R,Result2,Result).
% condition4: all not continous conditions
chop_up2([Head|Tail],Start,End,Result):-  
    T is End+1,
    Head \= T,
    cons2(Start,End,Head,Tail,R),
    chop_up2(Tail,Head,Head,Result2),
    cons(R,Result2,Result).
%base case
chop_up([],[]).
chop_up([Head|Tail],Result):-
    chop_up2(Tail,Head,Head,Result).

```
In this example, the sequence 9,10 has been replaced by [9,10], the sequence 5,6,7 has been replaced by [5, 7], and 2,3,4 has been replaced by [2, 4]. 

# 5
For this question we consider binary expression-trees whose leaves are either of the form tree(empty, Num, empty) where Num is a number, or tree(empty, z, empty) in which case we will think of the letter z as a kind of "variable". Every tree is either a leaf or of the form tree(L, Op, R) where L and R are the left and right subtrees, and Op is one of the arithmetic operators '+', '-', '*', '/' (signifying addition, subtraction, multiplication and division).
Write a predicate tree_eval(Value, Tree, Eval) that binds Eval to the result of evaluating the expression-tree Tree, with the variable z set equal to the specified Value. For example:
```prolog
?- tree_eval(2, tree(tree(empty,z,empty),
                 '+',tree(tree(empty,1,empty),
                      '/',tree(empty,z,empty))), Eval).
Eval = 2.5

?- tree_eval(5, tree(tree(empty,z,empty),
                 '+',tree(tree(empty,1,empty),
                      '/',tree(empty,z,empty))), Eval).
Eval = 5.2

```
```prolog
tree_size(_,empty, 0).
tree_eval(Zvalue,tree(empty, z, empty), Zvalue).
tree_eval(_,tree(empty, Value, empty), Value):-
    Value \= z.
tree_eval(Zvalue, tree(L, O, R), Eval):-
        tree_eval(Zvalue, L, Left_Eval),
        tree_eval(Zvalue, R, Right_Eval),
        cal(Zvalue,O,Left_Eval,Right_Eval,Eval).
cal(Zvalue,z,_,_,Zvalue).
cal(_,+,Left_Eval,Right_Eval,Ans):-
    Ans is Left_Eval + Right_Eval.
cal(_,-,Left_Eval,Right_Eval,Ans):-
    Ans is Left_Eval - Right_Eval.
cal(_,*,Left_Eval,Right_Eval,Ans):-
    Ans is Left_Eval * Right_Eval.
cal(_,/,Left_Eval,Right_Eval,Ans):-
    Ans is Left_Eval / Right_Eval.
```
scp ~/Desktop/ass1.pl z5098663@cse.unsw.edu.au:/import/adams/2/z5098663/comp9814
