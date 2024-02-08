# Harmonic functions on graphs

*Author: Daria Shutina*



## Introduction

Consider a finite graph $G$ with vertex set $V(G)$ and edge set $E(G)$. For vertices $v, v'$ we will write $v \sim v'$ if $v$ and $v'$ are joined by an edge. 

$f: V \rightarrow R$ is a *harmonic function* if it satisfies the condition:
$$
f(v) = \frac{1}{\deg v} \sum \limits_{v' \sim v} f(v')
$$
In simple words, a harmonic function associates a real number with each vertex. The value of vertex $v$ is an average of values of $v$'s neighbors. 



Harmonic functions are always constants. 

Suppose, a harmonic function $f$ reaches its maximum in $v$. $v_1, ..., v_n$ are neighbors of $v$.

$\left . \begin{array}{r} \forall i \ : \ f(v_i) \leqslant f(v) \textnormal{, since } f(v) = \max f \\ f(v) \textnormal{ is an average of } f(v_1),...,f(v_n) \end{array} \right\} \ \Longrightarrow \ f(v_1) = ... = f(v_n) = f(v)$.







## Uniqueness property

The term "uniqueness" ensures there's only one function satisfies the given conditions. In the context of harmonic functions, it implies that the function is constant in all vertices of the graph. 



Let $G$ be a finite connected graph. $W$ is a nonempty subset of vertices. $f \ : \ V \rightarrow R$ is a function such that $f|_W = 0$ and $f$ is harmonic at all points of $V \backslash W$.

We must prove that $f=0$ at all vertices. 



Assume that $f \neq 0$. Then there is a vertex $v$ such that $f(v) = \max f$ and $f(v) > 0$. If $f(v) < 0$, we can easily replace all values with the opposite ones. 

  $f|_W=0 \ \Rightarrow \ v \in V \backslash W$, so $f(v)$ is harmonic. As we know, $f(v)$ is an average of values which are at most $f(v)$. It means that $\forall v_0 \ : \ v_0 \sim v \ \Rightarrow f(v_0) = f(v)$. 

As a result, we come to a conclusion that $f$ is constant. $f|_W=0 \ \Rightarrow \ f = 0$ at all vertices.













