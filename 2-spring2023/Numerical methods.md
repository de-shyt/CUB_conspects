# Numerical methods

*Author: Daria Shutina*



[TOC]



## 23-02-02

Approaches to solving a problem:

- iteration:  $x_0 = c; \ x_n = f(x_{n-1})$ 
- interpolation -- choose a function which is the closest to the initial function
- integration -- use integrals



### Taylor series 

Given a function $f \ : \ R \rightarrow R$, which is infinitely differentiable at $c \in R$. The Taylor series of $f$ at $c$ is:

$f(x) = \sum \limits_{n=0}^{+\infty} \frac{f^{(n)}(x_0)}{n!}(x-c)^n$

If $c = 0$, then it is called ***the Maclaurin series***. 



*Note:* A power series have an interval/radius of convergence. $f^{(n)} \in \textnormal{radius of conv.}$

Given a function $f = \sum a_n x^n$. Then a radius of convergence of $f$ is $R = \frac{1}{\lim \limits_{n \rightarrow \infty} \sup \sqrt[n]{|a_n|}}$



*Note:* The smaller the difference between $x$ and $c$, the faster the Taylor series converge. 







### Taylor theorem

#### version 1

$f \in C^{n+1}([a, b])$  (n+1 times continuously differentiable in [a, b])

Then for $\forall c \in [a, b]$ we have that $f = \sum \limits_{k=0}^n \frac{f^{(k)}(c)}{k!}(x-c)^k + \underbrace{\frac{f^{(n+1)}(\xi_x)}{(n+1)!}(x-c)^{n+1}}_{E_n(x) \ - \ \textit{remainder}}$, where $\xi_x$ is between $x$ and $c$ and depends on $x$. 



#### version 2

$f \in C^{n+1}([a, b])$

For $x, x + h \in [a, b] \ \ f(x + h) = \sum \limits_{k = 0}^n \frac{f^{(k)}(x)}{k!} h^k + \frac{f^{(n+1)}(\xi_x)}{(n+1)!} h^{n+1}$, where $E_n(x) = O(h^{n+1})$











## 23-02-03

### Mean value theorem \todo

For $n = 0$ $f(x) = f(c) + f'(\xi_x) (x - c)$

$x := b, \ c := a \ \Rightarrow \ f(b) = f(a) + f'(\xi_x) (b - a) \ \Rightarrow \ f'(\xi_x) = \frac{f(b) - f(a)}{b - a}$

\todo картинка график 





***Definition:*** The Taylor series *represents* $f$ at $(.) x$  iff  the Taylor series converge at $(.) x$. 







### $f = e^x$ 

$c = 0, \ e^x = \sum \limits_0^n \frac{x^k}{k!} + \frac{e^{\xi_x}}{(n+1)!} x^{n+1} (*)$

For $\forall x \in R \ \exists s \in R_0^+ \ : \ |x| \leqslant s \ \and \ |\xi_x| \leqslant s$

$e^x$ is monotone increasing $\Rightarrow$ $e^{\xi_x} \leqslant e^s \ \Rightarrow \ \lim \limits_{n \rightarrow \infty} |\frac{e^{\xi_x}}{(n+1)!} x^{n+1}| \leqslant e^{s} \cdot \lim \limits_{n \rightarrow \infty} |\frac{s^{n+1}}{(n+1)!}| = 0 \ \Rightarrow \ (*)$ represents $e^x$ at $x$.

 



### $f = \ln(1 + x)$ \todo

$c = 0$

$f^{(k)}(x) = (-1)^{k-1} (k-1)! \frac{1}{(1 + x)^k}$

$g(x) = \sum \limits_0^n \frac{(-1)^{k-1}}{k} x^k + \frac{(-1)^n}{n+1} \cdot \frac{1}{(1 + \xi_x)^{n+1}} \cdot x^{n+1}$ 

 $\lim \limits_{n \rightarrow \infty} E_n(x) = \underbrace{\lim \limits_{n \rightarrow \infty} \frac{(-1)^n}{n+1}}_{\rightarrow 0} \cdot \lim \limits_{n \rightarrow \infty}(\frac{x}{\xi_x + 1})^{n+1} = 0 \ \Rightarrow \ 0 < \frac{x}{\xi_x + 1} < 1$

$\Rightarrow \ x \leqslant 1, \ if \ \xi_x \in [0, x]$ and $x > -1, \ if \ \xi_x \in [x, 0] \ \Rightarrow \ g$ represents $f$ at $x \in (-1, 1)$. 





### Counting $\cos(0, 1)$

$f = \cos x$

$g(x) = \sum \limits_0^n (-1)^k \frac{x^{2k}}{(2k)!} + (-1)^{n+1} \cos \xi_x \frac{x^{2(n+1)}}{(2(n+1))!}, \ c = 0$

$|(-1)^{n+1} \underbrace{\cos \xi_x}_{\leqslant 1} \cdot \frac{x^{2(n+1)}}{(2(n+1))!}| \leqslant |\frac{x^{2(n+1)}}{(2(n+1))!}|$

$|\frac{0,1^{2(n+1)}}{(2(n+1))!}| \ \underset{n \rightarrow \infty}{\rightarrow} \ 0 \ \Rightarrow \ g$ represents $f$ at $(.)0,1$. 










