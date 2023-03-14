# Automata, Computability & Complexity

*Author: Daria Shutina*



[TOC]



## 23-02-06

### Org stuff

For schemes: https://www.cs.unc.edu/~otternes/comp455/fsm_designer/



**Timetable:**

- Mondays 14:15 lectures offline. Moodle quiz in the beginning of each lecture
- Wednesdays 14:15 lectures offline 
- Thursdays 17:15 consultations online. Need to book 



**Grade:**

- 100% exam
- bonus 0.33 (5%) if 50% of quizes and 50% of homeworks are done





### von Neumann architecture

<img src="./pics for conspects/ACC/ACC 23-02-06 1.png" alt="ACC 23-02-06 1" style="zoom:67%;" />

Our nowadays computers are based on the von Neumann computer architecture. 





### Finite automata

For theory achievements, we will use a simpler compute model which gets
the input as a string of symbols, has no memory, and generates an output that is either
`accept` or `reject`.  This machine is called *finite automaton.*





### Deterministic finite automata

Deterministic means that an input symbol $a$ leads from state $q$ to exactly one possible state $q'$. 

The vizualization of the input computation is a chain.





#### Definitions

<img src="./pics for conspects/ACC/ACC 23-02-06 2.png" alt="ACC 23-02-06 2" style="zoom:50%;" />

A transition function can be described via *state transition diagram* (STD) or *state transition table*. 

If a state is a *start state*, it has an arrow pointing from nowhere. 

What is an *accept state*? Imagine we have an input. We go from one state to another, as the input says. Then we finish in a definite state. This state can be a final/accept state. In other words, it is where an input ends. Final states are shown as double-circled states in STD. 



FA accepts a string if it starts in a start state, uses only transitions of $\delta$ and finishes in one of final states. 

<img src="./pics for conspects/ACC/ACC 23-02-06 5.png" alt="ACC 23-02-06 5" style="zoom:50%;" />



A *computation of FA on a string* is a sequence of states such that it starts in a start state and uses only transitions of $\delta$. 



$L(M)$ -- *the language of machine M* -- is the set of <u>all</u> strings that are accepted by M. Every FA stil recognizes and empty language $\varnothing$. 







#### Example 1: a STD 

<img src="./pics for conspects/ACC/ACC 23-02-06 3.png" alt="ACC 23-02-06 3" style="zoom:67%;" />

$Q = \{ q_1, q_2, q_3 \}$;   $\Sigma = \{ 0, 1 \}$;   $F = \{ q_2 \}$.

$q_1$ is a start state. 

$\delta$ can be described with a table: 

<img src="./pics for conspects/ACC/ACC 23-02-06 4.png" alt="ACC 23-02-06 4" style="zoom:67%;" />

FA accepts a string $1101$, for example, since it starts in $q_1$ and finishes in $q_2$.





#### Example 2: finding FA

We consider a language $L = \{ w \ | \ w \ contains \ 001 \ as \ substring\}$. The alphabet is $\{ 0, 1 \}$. 

The idea is that we will have $4$ states: 

- $q$ -- no subsequence
- $q_0$ -- we have $0$
- $q_{00}$ -- we have 00
- $q_{001}$ -- we have $001$ and we neep to stop. 

<img src="./pics for conspects/ACC/ACC 23-02-06 7.png" alt="ACC 23-02-06 7" style="zoom:60%;" />



#### Example 3: finding a FA for a union of RLs

$M_1 = (S, \Sigma_1, \delta_1, q_{1}^0, , F_1)$

$M_2 = (T, \Sigma_2, \delta_2, q_2^0, F_2)$

We can finds a new FA for $M = (Q, \Sigma, \delta, q_0, F)$ where

$Q = S \times T$

$\Sigma = \Sigma_1 \cap \Sigma_2$ 

$\delta((s, t), a) = (\delta_s(s, a), \delta_t(t, a))$ 

$q_0 = (s_0, t_0)$

$F = F_1 \times F_2$





#### Regular language 

A language is called a *regular language* if $\exists$ FA that recognizes it. 

To prove that a language is regular, we need to build a FA that will recognize it. If we are able to build a STD, then the language is regular. 



**Example of a non-regular lenguage:**

$L = \{ 0^n 1^n \ | \ n \geqslant 1 \}$. 

$n$ is not fixed, so we have a problem with choosing a transition function. 







#### Regular operations

<img src="./pics for conspects/ACC/ACC 23-02-06 6.png" alt="ACC 23-02-06 6" style="zoom:50%;" />







### Th 1.1 (unoin operation of RLs)

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







### Th. 1.2 (concatenation operation of RLs)

The class of regular languages is closed under the concatenation operation.

$A_1, A_2$ are RLs $\Rightarrow$ $A_1 \textopenbullet A_2$ is a RL. 



*Proof:* его нет







## 23-02-13

### Nondeterministic finite automata

In contrast to deterministic FAs, nondeterministic FAs allow several successor states (or even none) for a given fixed input. An NFA adds more flexibility to the computation. 

- There can be several transitions with the same symbol 
-  There can also be no transition for some symbol
- There can be additional label $\epsilon$. It is like a special symbol (i.e., an empty string). Every alphabel has its own $\epsilon$ (provided that it has special symbols), 

The vizualization of the computation is a tree.





#### Definitions

<img src="./pics for conspects/ACC/ACC 23-02-13 3.png" alt="ACC 23-02-13 3" style="zoom:67%;" />

In the transition functin definition, $P(Q)$ means a set of states, since in NFA we can get from one state to several (or zero) states. 



NFA *accepts* a given input string, if there exists a computation branch in a tree that ends in an accept state; otherwise it *rejects* it.

<img src="./pics for conspects/ACC/ACC 23-02-13 4.png" alt="ACC 23-02-13 4" style="zoom:67%;" />



A *computation brance of NFA on a string* is a sequence of states such that it starts in a start state and uses only transitions of $\delta$. 

A computation branch is *accepting* if the last state after all transitions is an element of $F$; otherwise, it is a *rejecting* branch. 





#### Example of NFA

<img src="./pics for conspects/ACC/ACC 23-02-13 1.png" alt="ACC 23-02-13 1" style="zoom:67%;" />

Finally, we can to the conclusion that $L(N_1) = \{ \ w \ | \ w \textnormal{ contains either 101 or 11 as a substring} \ \}$. 





#### Creating a tree for an input

Let us consider an input $010110$ for the STD from the example above. The tree will be:

<img src="./pics for conspects/ACC/ACC 23-02-13 2.png" alt="ACC 23-02-13 2" style="zoom:67%;" />

$q_1 \rightarrow q_3$ is $1 + \epsilon$ that is equal to $1$. 







### Th 2.1 (equivalence between NFA and FA)

$\forall NFA \ \ N \ \ \exists FA \ \ M \ \ : \ \ L(M) = L(N)$.

In other words, all languages that can be recognized by an NFA, can also be recognized by some FA.



*Proof:*

We have an NFA $N = (Q, \Sigma, \delta, q_0, F)$ and we want to construct a deterministic FA $M = (Q', \Sigma, \delta', q_0', F')$. 

- $Q'$ includes subsets of $Q$ that are outcomes of $\delta$:  $Q' = P(Q)$. 

- $\delta'$ get a success if one of considered gates gets a success:   $\delta' = \bigcup \limits_{r \in R} \delta(r, a), \ \forall R \in Q', a \in \Sigma$. 

-  $q_0' = \{ q_0 \}$. The start state becomes a set, because $Q'$ consists of sets. 

- $F' = \{ \ R \in Q' \ | \ R \textnormal{ contains an accept state of } N \ \}$



We do not have $\epsilon$ in FA. What to do with $\epsilon$-transitions?

Let us create a set $E(R) = \{ \ q \in Q \ | \ \exists \{s_i \}_{0..m} \ : \ s_0 \in R \ \and \ s_m = q \ \and \ s_{i+1} \in \delta(s_i, \epsilon) \ \}$. 

A set $R$ is a state for FA: $R \in Q'$. 

A set $E(R)$ is a set of states for NFA: $E(R) \in Q$. It consists of such states that can be reached from $R$ only via $\epsilon$-transitions.

It is obvious that $R \in E(R)$:  $\delta(r, \epsilon) = r, \ \forall r \in R$. Thus, we can modify our function $\delta'$: $\delta'(R, a) = \bigcup \limits_{r \in R} E(\delta(r, a)), \ \forall R \in Q', a \in \Sigma$. As we can see, a set of values for $\delta'$ can become only larger.

 Also, we need to modify the start state: $q_0 = E(\{ q_0 \})$. 







### Corollary 2.1 (relation between RL and NFA)

Language is regular $\Leftrightarrow$ some NFA recognizes it.



*Proof:*

Language is regular $\Leftrightarrow$ $\exists$ FA that recognizes it $\underset{\textnormal{\scriptsize Th 2.1}}{\Leftrightarrow}$ $\exists$ NFA that recognizes it.







### Th 2.2 (star operation of RLs)

The class of regular languages is closed under the star operation:

$A$ is a RL $\Rightarrow$ $A^{*}$ is an RL.



*Proof:*

Remainder: $A^* = \{ \ x_1 x_2...x_k\ \ : \ k \geqslant 0 \ \and \ x_i \in A, \forall i \ \}$.

We have an NFA $N_1 = (Q_1, \Sigma, \delta_1, q_1, F_1)$ that recognizes $A$. We want to construct an NFA $N = (Q, \Sigma, \delta, q_0, F)$ such that it recognizes $A^*$. 

In the STD we $\color{red}{\textnormal{connect final states with the start state}}$ via $\epsilon$-transitions, thus we get a concatenation of elements. Also, there is also an empty string  $\epsilon$ as an input in $A^{*}$, so we choose a new start state by adding $\color{blue}{\textnormal{a new state}}$ to the initial start state:

<img src="./pics for conspects/ACC/ACC 23-02-13 6.png" alt="ACC 23-02-13 6" style="zoom:80%;" />

- $Q = \{q_0 \} \ \cup \ Q_1$
- $F = \{ q_0 \} \ \cup F_1$
- $\forall q \in Q, a \in \Sigma_{\epsilon} \ :$<img src="./pics for conspects/ACC/ACC 23-02-13 7.png" alt="ACC 23-02-13 7" style="zoom:53%;" />









## 23-02-20

### Reqular expressions

<img src="./pics for conspects/ACC/ACC 23-02-20 1.png" alt="ACC 23-02-20 1" style="zoom:67%;" />

$R \ \cup \ \varnothing \ = \ R$

$R \ \circ \ \epsilon \ = \ R$



$L((\Sigma \Sigma)^*) = \{ w \ | \ w \textnormal{ is a string if even (and 0) length} \}$.



<img src="./pics for conspects/ACC/ACC 23-02-20 2.png" alt="ACC 23-02-20 2" style="zoom:67%;" />



### Lemma 3.1

If a language is described by a regular expression, then it is regular.



*Proof:* 

We need to build an NFA $N$ which recognizes $L(R)$:  $L(N) = L(R)$.

A regular expression consists of six elementary cases. If we are able to build an NFA for each case, then we will show that construction of the required NFA is possible. 

The cases are:

- $\forall a \in \Sigma \ : \ a$ is accepted by some NFA:<img src="./pics for conspects/ACC/ACC 23-02-21 1.png" alt="ACC 23-02-21 1" style="zoom:50%;" />

- $\epsilon$ is accepted by some NFA:<img src="./pics for conspects/ACC/ACC 23-02-21 2.png" alt="ACC 23-02-21 2" style="zoom:50%;" />

- $\varnothing$ is accepted by some NFA $\Leftrightarrow$ Some NFA recognizes an empty language. 

  The NFA is:<img src="./pics for conspects/ACC/ACC 23-02-21 3.png" alt="ACC 23-02-21 3" style="zoom:50%;" />

- $R_1 \cup R_2$ is accepted by some NFA. It is true, since the class of regular languages is closed under the union operation ([Th. 1.1](###Th 1.1 (unoin operation of RLs)))

- The same is for $R_1 \circ R_2$ and $R^{*}$ ([Th. 1.2](###Th. 1.2 (concatenation operation of RLs)) and [Th. 2.2](###Th 2.2 (star operation of RLs)))

We have an NFA $\Rightarrow$ we can build an FA ([Th. 2.1](###Th 2.1 (equivalence between NFA and FA))) $\Rightarrow$ the given language is regular. 







### Example: building an NFA

$R = (\textcolor{blue}{ab} \ \cup \ \textcolor{blue}{a})^{\textcolor{red}{*}}$. Build an NFA that recognizes $L(R)$. 

Build seperate branches for $\textcolor{blue}{blue}$ pieces, then connect finish points with "pseudo-start" point to implemet $\textcolor{red}{*}$. 

<img src="./pics for conspects/ACC/ACC 23-02-20 3.png" alt="ACC 23-02-20 3" style="zoom:67%;" />





### GNFA: generalized nondeterministic finite automaton

#### Definition

<img src="./pics for conspects/ACC/ACC 23-02-20 4.png" alt="ACC 23-02-20 4" style="zoom:67%;" />



#### Example

<img src="./pics for conspects/ACC/ACC 23-02-20 5.png" alt="ACC 23-02-20 5" style="zoom:67%;" />

A GNFA is an NFA, such that we associate to each transition a *regular expression* instead of a symbol of the alphabet.

The start state and the accept state are distinct. We require that each state, which is not the start or the accept state, has transitions to <u>all</u> other states, including itself. For the start state, there exist outgoing transitions to all other states, but no incoming connections. The accept state has only incoming connections that come from all states. 



<img src="./pics for conspects/ACC/ACC 23-02-20 6.png" alt="ACC 23-02-20 6" style="zoom:67%;" />









### Th. 3.1 (equivalence between FA and GNFA)

For each FA $M$, there is a GNFA $G$, such that $L(G) = L(M)$.



*Proof:*

We have an FA $M = (Q, \Sigma, \delta, q_0, F)$. We want to construct an GNFA $G = (Q', \Sigma, \delta', q_{start}, q_{accept})$ such that $L(G) = L(M)$. 

We add states $q_{start}$ and $q_{accept}$. $Q' = Q \cup \{ q_{start}, \ q_{accept}\}$

$q_{start}$ has an $\epsilon$-transition to $q_0$. 

$q_{accept}$ gets $\epsilon$-transitions from all $q \in F$. 

<img src="./pics for conspects/ACC/ACC 23-02-21 4.png" alt="ACC 23-02-21 4" style="zoom:60%;" />

$\mathcal{U(A)}$ is the operation that builds a regular expression from the language $A$. For example, $\mathcal{U}(\{a, b, c\}) = a \cup b \cup c$.	





#### Example

FA is on the left side, GNFA is on the reight side. 

<img src="./pics for conspects/ACC/ACC 23-02-20 7.png" alt="ACC 23-02-20 7" style="zoom:67%;" />







### Lemma 3.3 \todo

If a language is regular, then it is decribed by a regular rexpression.



*Proof:*

\todo







### Th.

Language is regular $\Leftrightarrow$ it can be described with a regular expression. 

*Proof:* it is true because of Lemmas 3.1 and 3.3. 









## 23-02-27

###  Nonregular Languages

*The Pumping Lemma* helps to decide whether a language is not regular. Its point is that, for a regular language, strings beyond a certain size contain parts that can be repeated (“pumped up”) arbitarily often while keeping the string in the same language.





#### the Pumping Lemma

$\Sigma$ is an alphabet and $A$ is a language over $\Sigma$. 

$A$ is regular $\Rightarrow$ there exists $p$ such that any string $s \in A$ of length at least $p$ can be divided into three pieces $x, y, z$ which satisdy the following conditions:

-  $\forall i \geqslant 0 \ : \ xy^iz \in A$
- $|y| > 0$
- $|xy| \leqslant p$

$p$ is called *the pumping length*.





##### Example 1

$B = \{ 0^n 1^n \ | \ n \geqslant 0 \}$ is a nonregular language. 

*Proof:*

If $B$ is regular, then $\exists p$ from the Pumping Lemma. Let us consider a sting $0^p1^p \in B$ and try to divide it into three pieces

1. $y$ consists only of $0$s. Then a string $xyyz$ has more $0$s then $1$s $\Rightarrow$ $xyyz \not \in B$.
2. $y$ consists only of $1$s. The same as in point 1.
3. $y$ consists of $0$s and $1$s. Then in a string $xyyz$ we can find $0$ and $1$ that go in the wrong order ($1$ is before $0$) $\Rightarrow$ $xyyz \not \in B$.



##### Example 2 \TODO

$F = \{ \ ww \ | \ w \in \{ 0, 1\}^* \ \}$ is nonregular. 

*Proof:* \TODO







### Context-Free Grammars

Like regular expressions, they are a means to describe languages. 

The language class counterpart for context-free grammars will be context-free languages (CFL), similar to regular languages that are the language class counterpart for regular expressions. 

Note that a CFG can be ambiguous, i.e. there might be more than one way to generate a given string.

<img src="./pics for conspects/ACC/ACC 23-02-27 1.png" alt="ACC 23-02-27 1" style="zoom:67%;" />









## 23-03-13

### Pushdown Automata

A pushdown automaton is an NFA with the addition of an (infinite) stack.







###  mPDA to CFG

Let $P = (Q, \Sigma, \Gamma, \delta, q_0, \{ q_{accept}\})$ be an mPDA.



$G(P) = \{ V, \Sigma, R, S \}$ is a CFG built from $P$. The final state in $G(P)$ should be only one. So, in case of several final states:

1. create a new state and connect it to old final states via a new symbol (i.e. `#`)
2. create a new start state and connect it to the old start state via the same new symbol. 



$V = \{ A_{pq} | p,q \in Q \}$ are variables of $G(P)$.



$A_{pq}$ generates all strings going from state $p$ to state $q$ with same stack height (this means height of stack in state $p$ is the dame as in state $q$).



In mPDA we cannot simultaneously push to stack and pop from it. If we have PDA,  we can add a new state for a stack modification $a \rightarrow b$, where one step will be $a \rightarrow \epsilon$, and another step will be $\epsilon \rightarrow b$. 

<img src="./pics for conspects/ACC/ACC 23-03-13 5.png" alt="ACC 23-03-13 5" style="zoom:67%;" />



There are three rules $R$:



1: $\forall p \in Q \ : \ A_{pp} = \epsilon$



2: $\forall p, q, r \in Q \ : \ A_{pq} \rightarrow A_{pr} A_{rq}$. If $A_{pr}$ or $A_{rq}$ does not generate anything, then the rule does not generate anything either. 

<img src="./pics for conspects/ACC/ACC 23-03-13 2.png" alt="ACC 23-03-13 2" style="zoom:50%;" />



3: $\delta(p, a, \epsilon) = \{ (r, t),... \}$ and $\delta(s, b, t) = \{ (q, \epsilon),... \}$, then $A_{pq} \rightarrow a A_{rs} b$

<img src="./pics for conspects/ACC/ACC 23-03-13 4.png" alt="ACC 23-03-13 4" style="zoom:80%;" />

We looks at states $p, q$ on the same stack height. If we push the element $x$ in the beginning, then in the end we pop the same element $x$.

So, in the beginning we read $a$ and push $x$ (without popping anything). Then $A_{rs}$ goes. Then we read $b$ and pop $x$ (without pushing anything). Thus, we get the rule written above. 
