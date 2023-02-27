# Compilers

*Author: Daria Shutina*



[TOC]

## 23-02-23

There are several ways to define semantics of the language:

- write a document with standards

- Write an interpreter and a compiler 
- Use formal semantics. You have a start state, a finish state and a transition function



Let us define an expression $E$ which is a variable, an integer or a binary operation:

$E := X \ | \ N \ | \ Binop \ \times \ E \ E$, where $X = \{ a, b, c,...\}, \ \times = \{ +, -, *, \backslash, \%, <, ... \}$.

We can see any expression as a binary tree. 



The semantics of the language is a total map:

$\underbrace{[ \ | \ . \ | \ ]}_{\textnormal{semantics}} \ : \ \underbrace{E}_{\textnormal{\small expressions}} \rightarrow \underbrace{D}_{\textnormal{\small semantics domain}}$

$D = (X \rightarrow Z) \rightarrow Z$ -- we got a variable, turn it into an integer, then turn the integer into the result integer. 







### Interpreters

We have the input and the output. An interpreter takes a program and its input as arguments, and returns what the program would return. 





#### A simple interpreter 

$\sigma \in E$

- $n \in N; \ \sigma \overset{n}{\longrightarrow} n$

- $x \in X; \ \sigma \overset{x}{\longrightarrow} \sigma(x)$

- $\sigma \overset{l \times_1 r}{\longrightarrow} x \times_2 y$





#### A smarter interpreter

$S = X \ | \ N \ | \ read \ | \ write \ | \ skip \ | \ Binop \ | \ \underbrace{S_1; \ S_2}_{\textnormal{\small composition of expressions}}$ 

In this case, `;` is a concatenation operator

$[ \ | \ . \ | \ ]_{s} \ : \ S \rightarrow D$

The simplest idea for the output is a set of numbers. 



- $c \overset{skip}{\longrightarrow} c$

- $(\sigma, w) \overset{x := e}{\longrightarrow} (\sigma[x \leftarrow [\ |e| \ ]_{\sigma}, w)$

- $(\sigma, (i \ : \ is \ : \ o)) \overset{read(x)}{\longrightarrow} (\sigma[x \leftarrow i], (is, o))$ $\textcolor{grey}{(i \ : \ is \ : \ o \ - \ i \textnormal{ is head}, \ is \textnormal{ is tail})}$

  We take the first number and assign it into $x$ (that is what $\sigma$ does). 

- $(\sigma, (i, o)) \overset{write(e)}{\longrightarrow} (\sigma, (i, o ++ [|e|]_{\sigma}))$
- $\left . \begin{array}{l} c \overset{s_1}{\longrightarrow} c' \\ c' \overset{s_2}{\longrightarrow} c'' \end{array} \right \} \ \Rightarrow \ c \overset{s_1; s_2}{\longrightarrow} c''$



##### Example

<img src="./pics for conspects/COMP/COMP 23-02-23 1.png" alt="COMP 23-02-23 1" style="zoom:90%;" />