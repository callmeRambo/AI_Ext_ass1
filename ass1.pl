% z5098663, Yichen Zhu, Assignment 1 - Prolog Programming


% 1.sumsq_neg(Numbers, Sum) that sums the squares of only the negative numbers in a list of numbers
% base case [] returns 0.
sumsq_neg([], 0).
% two conditions, >= or < zero.
% There is to negelect postive number.
sumsq_neg([Head|Tail], Count) :-
    Head>=0, sumsq_neg(Tail, Count).    
sumsq_neg([Head|Tail], Count) :-
    Head<0, sumsq_neg(Tail, TailCount),
    Count is TailCount + Head*Head.

% likes(mary, apple).
% likes(mary, pear).
% likes(mary, grapes).
% likes(tim, mango).
% likes(tim, apple).
% likes(jane, apple).
% likes(jane, mango).

% 2. 
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

% 3. binds Result to the list of pairs consisting of a number and its square root, from N down to M
%format the answer
comb(A,B,Res):-
    Res = [A,B].
% get the sqrt and format the answer. 
sqrt_1(A,Result):-    
    X is sqrt(A),
    Result = [A,X]. 

sqrt_2(A,B,Result):-
    A>=B,sqrt_1(A,Result).
sqrt_2(A,B,Result):-
    A>=B,
    Res is A -1,
    sqrt_2(Res,B,Result).

sqrt_table(A,B, Result):-
    findall(X, sqrt_2(A,B, X), Result).


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

% 5.binary expression-trees
tree_size(_,empty, 0).
tree_eval(Zvalue,tree(empty, z, empty), Zvalue).
tree_eval(_,tree(empty, Value, empty), Value):-
    Value \= z.
tree_eval(Zvalue, tree(L, O, R), Eval):-
    % travel left tree and right tree and sum up the answer.
        tree_eval(Zvalue, L, Left_Eval),
        tree_eval(Zvalue, R, Right_Eval),
        cal(Zvalue,O,Left_Eval,Right_Eval,Eval).
cal(Zvalue,z,_,_,Zvalue).
% operations
cal(_,+,Left_Eval,Right_Eval,Ans):-
    Ans is Left_Eval + Right_Eval.
cal(_,-,Left_Eval,Right_Eval,Ans):-
    Ans is Left_Eval - Right_Eval.
cal(_,*,Left_Eval,Right_Eval,Ans):-
    Ans is Left_Eval * Right_Eval.
cal(_,/,Left_Eval,Right_Eval,Ans):-
    Ans is Left_Eval / Right_Eval.