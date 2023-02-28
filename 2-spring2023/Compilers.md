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











## 23-02-28

We can have an instruction $I$ which is:

$I = const N \ | \ LD  \ x \ | \ ST \ x \ | \ Binop \ | \ Read \ | \ Write$

Program $p$ is a set of indtructions: 

$p = [I]$



**Example:**

$2 + 3 * 4$ consists of $Const \ 2$, $Const \ 3$, $Const 4$, $Binop \ +$, $Binop \ *$. We can draw a tree:

\TODO draw a tree





\TODO rewrite

$[|.|]_{SM} \ : \ P \rightarrow D$ where $D$ (domain) is $Z^* \times (X \rightarrow Z) \times Z^* \times Z^*$ -- a tuple {stack, mapping function, input, output}. The mapping function maps a variable to an integer. 

Initial state is $<\epsilon, \Lambda, i, \epsilon>$.

$<S, \delta, i, o> \overset{(Const \ n) p}{\longrightarrow} <n : S, \delta, i, o>$

$<S, \delta, i, o> \overset{(LD \ x) p}{\longrightarrow} <\delta(x) : S, \delta, i, o>$

$<S, \delta, i, o> \overset{(ST \ x) p}{\longrightarrow} $







### Semantics for compiler \TODO

$[|.|]^{\epsilon}_{comp} \ : \ E \rightarrow P$ -- function for expressions

$[|Const \ n|]^{\epsilon}_{comp} = [Const \ n]$

$[|x|]^{\epsilon}_{comp} = [LD \ x]$

$[|l \ Binop \ r|]^{\epsilon}_{comp} = [|l|]_{comp} ++ [|r|]_{comp}$ ($l$ and $r$ are expressions)



$[|.|]^S_{comp} \ : \ S \rightarrow P$ -- function for statements

$[|skip|]^S_{comp}  = [ \ ]$

$[|x = e|]^S_{comp}  = [|e|]^{\epsilon}_{comp} ++ [ST \ x]$

$[|read(x)|]^S_{comp} = [Read; ST \ x]$

$[|write(x)|]^S_{comp} = [|e|]^{\epsilon}_{comp} ++ [Write]$

$[|S_1 ; S_2|]^S_{comp} = [|S_1]^S_{comp} ++ [|S_2|]^S_{comp}$







Print `Hello world`

```
	.data
str: .string "aboba\n"

	.text
	.globl main
	
main: 
	pushl $str ; put a string on the top of the stack
	call printf ; 
```



