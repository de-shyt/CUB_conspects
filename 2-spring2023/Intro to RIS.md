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

   It is a right-associative.

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





### Inverse

Given a matrix $A$, its inverse is a matrix $A^{-1}$ such that $A A^{-1} = A^{-1} A = 1$. 

$\exists A^{-1} \ \Rightarrow$ $A$ is invertible and non-singular. Otherwise, it is singular. 

Inverse matrices do not exist for non-square matrices. 



#### Properties

- $(A^{-1})^{-1} = A$
- $(AB)^{-1} = B^{-1} A^{-1}$









## 23-02-10

### 2d rotation matrix

Counter-clockwise by the angle $\theta$:

$R = \begin{pmatrix} \cos \theta & -\sin \theta \\ \sin \theta & \cos \theta \end{pmatrix}$

Clockwise by the angle $\theta$:

$R^T = \begin{pmatrix} \cos \theta & \sin \theta \\ -\sin \theta & \cos \theta \end{pmatrix}$



Properties of $R$:

- $R \cdot R^T = E$
- $\det R = 1$





### Homogeneous coordinates

#### Adding a constant

In order to be able to add a constant, we add `1` to the end of a matrix: 

$\begin{pmatrix} a & b & c \\ d & e & f \\ 0 & 0 & 1 \end{pmatrix} \cdot \begin{pmatrix} x & y & 1 \end{pmatrix} = \begin{pmatrix} ax + by + c \\ dx + ey + f \\ 1 \end{pmatrix}$.

Such systems are called *homogeneous*. A homogeneous transformation matrix wil have a row `[0 0 1]` at the bottom, so there will be `1` at the bottom of the result matrix. 





#### 2d translation

The matrix have the form of $\begin{pmatrix} 1 & 0 & \ldots & t_1 \\ 0 & 1 & \ldots & t_2 \\ 0 & 0 & \ldots & t_3 \\ & \ldots \\ 0 & 0 & \ldots & 1 \end{pmatrix}$. 

$\begin{pmatrix} t_1 \\ \ldots \\ t_n \end{pmatrix}$ is an addition of a constants to the initial coordinates. 

<img src="../../../Desktop/studying/JUB_conspects/2-spring2023/pics for conspects/RIS 23-02-10 1.png" alt="RIS 23-02-10 1" style="zoom:67%;" />





#### Scaling

The matrix has a form of $\begin{pmatrix} s_1 & 0 & \ldots & 0 & 0 \\0 & s_2 & \ldots & 0 & 0 \\ && \ldots \\0 & 0 & \ldots & s_n & 0 \\ 0 & 0 & \ldots & 0 & 1 \\ \end{pmatrix}$.

$s_1, ..., s_n$ are scalars for the initial coordinates. 

<img src="../../../Desktop/studying/JUB_conspects/2-spring2023/pics for conspects/RIS 23-02-10 2.png" alt="RIS 23-02-10 2" style="zoom:67%;" />





### Linear independence

$I$ is a set of indexes. 

The system $\{ v_i \}_{i \in I}$ is *linearly dependent*, if one of the statements below are true:

1. $\nexists i \in I \ : \ v_i = \sum \limits_{j \neq i} v_j$
2. $\forall \{ a_i \} \in R \ : \ \Sigma a_i v_i = 0 \ \Rightarrow \ a_i = 0, \forall i \in I$.



*Proof that $1 \Leftrightarrow$ 2*:

 





### Matrix rank

Suppose we have a $m \times m$ matrix. 

If its rank is $m$ then it is *full rank* and it has an inverse matrix. 

If its rank is $<m$ then it is *singular* and does not have an inverse matrix. We also cannot restore the input. 







### Eigenvectors and eigenvalues

Given a matrix $\mathcal{A}$ of size $n \times n$.

$v \in V/\{0\}$ is an *eigenvector* if $\exists \lambda \ : \ \mathcal{A}(v) = \lambda v$.

$\lambda$ is an *eigenvalue*.



$p_{\mathcal{A}}(\lambda) = \det(\mathcal{A} - \lambda E)$ is a *characteristic polynomial* of matrix $\mathcal{A}$.







#### Th. (why do we need to substract $\lambda$ on the diagonal of the matrix)

$\lambda$ is an eigenvalue $\Leftrightarrow$ $(\mathcal{A} - \lambda E)(v) = 0$ $\Leftrightarrow$ $\det(A - \lambda E) = 0$



*Proof:*

$\mathcal{A} - \lambda v = 0 \ \Leftrightarrow \ (\mathcal{A} - \lambda E) v = 0 \ \Leftrightarrow Ker(\mathcal{A} - \lambda E) \neq \varnothing \ \underset{(*)}{\Leftrightarrow} \ \det(\mathcal{A} - \lambda E) = 0$.

For $(*)$, $\det(\mathcal{A} - \lambda E) = 0 \Leftrightarrow$ $\mathcal{A} - \lambda E$ is not inversible $\Leftrightarrow$ $Im(\mathcal{A} - \lambda E) \neq V$ $\Leftrightarrow$ $Ker(\mathcal{A} - \lambda E) \neq \varnothing$.







#### Th. (relation between eigenvalue and characteristic polynomial)

$\lambda$ is an eigenvalue  $\Leftrightarrow$  $\lambda$ is the root of the characteristic polynomial



*Proof:*  

$\lambda$ is an eigenvalue  $\Leftrightarrow$  $\det(\mathcal{A} - \lambda E) = p_{\mathcal{A}}(\lambda) = 0$ 







#### Example

$\mathcal{A} = \begin{pmatrix} 3 & -1 \\ -3 & 5 \end{pmatrix}$.

$p_{\mathcal{A}}(\lambda) = \det \begin{pmatrix} 3 - \lambda & -1 \\ -3 & 5 - \lambda \end{pmatrix} = \lambda^2 - 8 \lambda + 12 = 0$.

$\lambda_1 = 6, \ \lambda_2 = 2$.



$\mathcal{A} v_1 = \lambda_1 v_1 \ \Rightarrow \ v_1 = \begin{pmatrix} 1 \\ -3 \end{pmatrix}$

$\mathcal{A} v_2 = \lambda_2 v_2 \ \Rightarrow \ v_2 = \begin{pmatrix} 1 \\ 1 \end{pmatrix}$





#### Diagonolize

Typically an $n \times n$ matrix has $n$ different eigenvalues and $n$ associated eigenvectors. 

If there are $n$ independent eigenvectors, they can be used as a basis for $V$. Thus, we get a matrix $B = \begin{pmatrix} v_1 & ... & v_n \end{pmatrix}$ of the size $n \times n$. 

The diagonal matrix for $\mathcal{A}$ is $D = \begin{pmatrix} \lambda_1 & 0 & \ldots & 0 & 0 \\ 0 & \lambda_2 & \ldots & 0 & 0 \\ && \ldots \\ 0 & 0 & \ldots & 0 & \lambda_n \end{pmatrix}$. 

Finally, we come to $\mathcal{A} = B D B^{-1}$. You should be able to confirm this statement :^)





#### Trace and determinant

$p_{\mathcal{A}}(\lambda) = \det(\mathcal{A} - \lambda E) = \lambda^n - \textcolor{blue}{\textnormal{tr} \mathcal{A}} \cdot \lambda^{n-1} + \ldots + (-1)^n \cdot \textcolor{red}{\det \mathcal{A}}$.



$\textnormal{tr} \mathcal{A} = \textnormal{tr} D = \lambda_1 + \ldots + \lambda_n$.

$\det \mathcal{A} = \det D = \lambda_1 \cdot \ldots \cdot \lambda_n$. 

























