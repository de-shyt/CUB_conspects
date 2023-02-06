# Automata, Computability & Complexity

*Author: Daria Shutina*



[TOC]



## 23-02-06

### von Neumann architecture

<img src="./pics for conspects/ACC 23-02-06 1.png" alt="ACC 23-02-06 1" style="zoom:67%;" />

Our nowadays computers are based on the von Neumann computer architecture. 





### Finite automata

For theory achievements, we will use a simpler compute model which gets
the input as a string of symbols, has no memory, and generates an output that is either
`accept` or `reject`.  This machine is called *finite automaton.*





#### Definitions

<img src="../../../Desktop/studying/JUB_conspects/2-spring2023/pics for conspects/ACC 23-02-06 2.png" alt="ACC 23-02-06 2" style="zoom:50%;" />

A transition function can be described via *state transition diagram* (STD) or *state transition table*. 

If a state is a *start state*, it has an arrow pointing from nowhere. 

What is an *accept state*? Imagine we have an input. We go from one state to another, as the input says. Then we finish in a definite state. This state can be a final/accept state. In other words, it is where an input ends. Final states are shown as double-circled states in STD. 



FA accepts a string if it starts in a start state, uses inly iterations of $\delta$ and finishes in one of final states. 

<img src="../../../Desktop/studying/JUB_conspects/2-spring2023/pics for conspects/ACC 23-02-06 5.png" alt="ACC 23-02-06 5" style="zoom:50%;" />



A *computation of FA on a string* is a sequence of states such that it starts in a start state and uses only iterations of $\delta$. 



$L(M)$ -- *the language of machine M* -- is the set of <u>all</u> strings that are accepted by M. Every FA stil recognizes and empty language $\varnothing$. 







#### Example 1: a STD 

<img src="../../../Desktop/studying/JUB_conspects/2-spring2023/pics for conspects/ACC 23-02-06 3.png" alt="ACC 23-02-06 3" style="zoom:67%;" />

$Q = \{ q_1, q_2, q_3 \}$;   $\Sigma = \{ 0, 1 \}$;   $F = \{ q_2 \}$.

$q_1$ is a start state. 

$\delta$ can be described with a table: 

<img src="../../../Desktop/studying/JUB_conspects/2-spring2023/pics for conspects/ACC 23-02-06 4.png" alt="ACC 23-02-06 4" style="zoom:67%;" />

FA accepts a string $1101$, for example, since it starts in $q_1$ and finishes in $q_2$.





#### Example 2: finding FA /todo

We consider a language $L = \{ w \ | \ w \ contains \ 001 \ as \ substring\}$. The alphabet is $\{ 0, 1 \}$. 

The idea is that we will have $4$ states: 

- $q$ -- no subsequence
- $q_0$ -- we have $0$
- $q_{00}$ -- we have 00
- $q_{001}$ -- we have $001$ and we neep to stop. 

/todo нужна картинка 







#### Regular language 

A language is called a *regular language* if $\exists$ FA that recognizes it. 

To prove that a language is regular, we need to build a FA that will recognize it. If we are able to build a STD, then the language is regular. 



**Example of a non-regular lenguage:**

$L = \{ 0^n 1^n \ | \ n \geqslant 1 \}$. 

$n$ is not fixed, so we have a problem with choosing a transition function. 







#### Regular operations

<img src="../../../Desktop/studying/JUB_conspects/2-spring2023/pics for conspects/ACC 23-02-06 6.png" alt="ACC 23-02-06 6" style="zoom:50%;" />







### Th (unoin operation of RLs)

The class of regular languages is closed under the union operation:

$A_1, A_2$ are RLs $\Rightarrow$ $A_1 \cup A_2$ is a RL.



*Proof:*

There are regular languages $A_1$ and $A_2$. W

There exists FAs $M_1$ and $M_2$ such that 
$$
\left \{ 
\begin{array}{l} L(M_1) = A_1, \ M_1 = (S, \Sigma, \delta_1, s_0, F_1) \\ L(M_2) = A_2, \ M_2 = (T, \Sigma, \delta_2, t_0, F_2) \end{array}
\right .
$$
If $M_1$ and $M_2$ have different alphabets, then $\Sigma$ will be the union of their alphabets. 



To show that $A_1 \cup A_2$ is a RL, we construct a FA $M$ such that $M = (Q, \Sigma, \delta, q_0, F)$

$Q = S \times T$

$\Sigma$ is the same

$\delta((s, t), a) = (\delta_s(s, a), \delta_t(t, a))$ 

$q_0 = (s_0, t_0)$

$F = F_1 \times F_2$







### Th. (concatenation operation of RLs)

The class of regular languages is closed under the concatenation operation.

$A_1, A_2$ are RLs $\Rightarrow$ $A_1 \textopenbullet A_2$ is a RL. 



*Proof:* его нет











