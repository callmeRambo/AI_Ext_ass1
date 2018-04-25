# COMP9814 REVIVE
## week3 Path Search
 Reactive and Model-Based Agents choose their actions based only on
what they currently perceive, or have perceived in the past.

 a Planning Agent can use Search techniques to plan several steps
ahead in order to achieve its goal(s).

 two classes of search strategies:

◮ Uninformed search strategies can only distinguish goal states from
non-goal states

◮ Informed search strategies use heuristics to try to get “closer” to
the goal

agent几大要素：
1。states 2. operators 3. goal test 4. path cost 于DL中rl的agent类似。

此处需要引出seach tree算法 Uniform search:
1. uniform-cost search:从root向最小代价节点展开
2. BFS
3. DFS
4. Deep limit search: Expands nodes like Depth First Search but imposes a cutoff on the maximum depth of path.
5. Iterative Deepening Search:
Tries to combine the benefits of depth-first (low memory) and
breadth-first (optimal and complete) by doing a series of depthlimited
searches. Early states will be expanded multiple times, but that might not matter too much because most of the nodes are near the leaves.



## Week4 informed search
A*算法
f(n) = g(n) + h(n).
h(n)是启发式方程，如过对于所有点，f（n）都小于等于真实值那么就是是最优的，因为永远不会过多估计。
这个算法难点在于取h（n）。