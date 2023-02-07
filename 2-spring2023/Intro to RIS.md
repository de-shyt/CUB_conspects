# Introduction to Robotics 

*Author: Daria Shutina*



[TOC]

## 23-02-03

### Sections of mechanics

**Statics** is concerned with the analysis of loads (force and torque, or "moment") acting on physical systems that do not experience an acceleration (a=0), but rather, are in static equilibrium with their environment.

**Kinematics** describes the motion of points, bodies (objects), and systems of bodies (groups of objects) without considering properties of objects (mass, density) or the forces that caused the motion.

**Kinetics** is concerned with the relationship between motion and its causes, specifically, forces and torques. 







## 23-02-07

### Matrix operations

1. Addition

2. Scaling: $\begin{pmatrix} a & b \\ c & d \end{pmatrix} \cdot 3 = \begin{pmatrix} 3a & 3b \\ 3c & 3d \end{pmatrix}$

3. Dot product (inner product): $\begin{pmatrix} x_1 \ldots x_n \end{pmatrix} \cdot \begin{pmatrix} x_1 \\ \vdots \\ x_n \end{pmatrix} = \begin{pmatrix} a_1 \end{pmatrix}$

4. Multiplication -- consists of several dot product operations 

5. Transposition: $A^T \ : \ a^T_{ij} = a_{ji}, \ \forall i, j$

   Also, $(ABC)^T = C^T B^T A^T$

6. Inverse

7. Determinant

8. Power (only for square matrices)

9. Trace -- sum of elements on the diagonal

   $\textnormal{tr} AB = \textnormal{tr} BA$

   $\textnormal{tr} (A + B) = \textnormal{tr} A + \textnormal{tr} B$

10. etc (maybe)





### Vector norm

A norm is a function $f \ : \ R^n \rightarrow R$ that satisfies 4 properties:

1.  Non-negativity: $\forall x \in R^n \ : \ f(x) \geqslant 0$
2.  Definiteness: $f(x) = 0 \Rightarrow x = 0$
3.  Homogeneity: $\forall x \in R^n, t \in R \ : \ f(tx) = |t| f(x)$
4. Triangle inequality: $\forall x, y \in R^n \ : \ f(x + y) \leqslant f(x) + f(y)$



Euclidean vector norm (2-norm): $||x||_2 = \sqrt{\sum \limits_{i = 1}^{n} x_i^2}$

$||x||_2 = \sqrt{x^{T} x}$

General $p$-norms, $p \geqslant 1$:   $||x||_p = (\sum \limits_{i=1}^n |x_i|^p)^{\frac{1}{p}}$

$||x||_{\infty} = \max \limits_i |x_i|$





### Matrix multiplication

- associative: $(AB)C = A(BC)$
- distributive: $A(B+C) = AB + AC$
- non-commutative: $AB \neq BA$





### Determinant



#### Properties

- $\det AB = \det BA$
- $\det A^{-1} = \frac{1}{\det A}$
- $\det A^T = \det A$



