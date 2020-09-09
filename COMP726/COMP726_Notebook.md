<center>COMPSCI726: Nonlinear Optimization I</center>  
<center>Notebook</center>
<center>Zijie Zhang </center>

- [Overview](#overview)
  - [Basic Information](#basic-information)
  - [Textbook](#textbook)
  - [Workload and Assessment](#workload-and-assessment)
  - [Topics Covered in Class](#topics-covered-in-class)
- [Lecture 1](#lecture-1)
  - [Our standard optimization problem:](#our-standard-optimization-problem)
  - [Specifying the optimization problem](#specifying-the-optimization-problem)


><center>2020/09/04/Friday === Create Notebook</center>

# Overview
## Basic Information
**Meetings:** Mon and Wed 2.30-3.45pm on BBC Ultra   
**Instructor:** Jelena (pronounced as Yelena) Diakonikolas  
**Email:** <jelena@cs.wisc.edu>  
**Office hours:** Mon 9-10am and 4-5pm  
**TA:**  Eric Lin  <clin353@wisc.edu>; OH: Wed 9-10am and 4-5pm

## Textbook
_Nocedal & Wright (Numerical Optimization, 2nd ed, 2006)_  

## Workload and Assessment
* Homework (5-6):
  * 30% of the grade
  * a combination of math problems and coding assignments
  * no collaboration allowed; any discussion must be verbal-only
* Midterm:
  * 30% of the grade
  * to be scheduled in mid-October
  * typically 4 multi-part questions of a similar format/difficulty as homework questions
* Final:
  * 40% of the grade
  * scheduled for 12/16/2020
  * similar format to midterm

## Topics Covered in Class
* Introduction: optimization background; convex sets; convex functions; convergence rates.
* Background on smooth unconstrained optimization: Taylor theorem and optimality conditions.
* First-order methods:
  * gradient descent for convex and nonconvex optimization, line search methods
  * projections, gradient mapping, and their use in projected gradient descent
  * Bregman divergence and mirror descent
  * Nesterov acceleration for convex optimization
  * conjugate gradients; lower bound for smooth convex minimization
  * conditional gradients (Frank-Wolfe methods)
  * stochastic gradient descent
* Second-order methods
  * Newton method
  * trust-region Newton
  * inexact Newton methods and Newton-CG
  * cubic regularization
  * quasi-Newton methods (DFP, BFGS, SR-1, general Broyden class)
  * limited-memory quasi-Newton (L-BFGS)

# Lecture 1
## Our standard optimization problem:
$$ \min_{x\in X} f(x) \ \ \ \ \ (P)$$
where $x$ is **vector**, $X$ is **feasible set**, $f(x)$ is **objective function**.  
$$ max_{x\in X} f(x) \Leftrightarrow \min_{x\in X} -f(x) $$

the value of (P): val(P) = $\inf_{x\in X}f(x)$.  
To give (P) a meaning, we need to specify:
* vector space, feasible set, objective function
* what is means to "solve" (P)  

Q: Can we even hope to solve an aribitrary opt. problem?  
Ex: Can you come up with an example of positive integers $x,y,z$ s.t. (Pythagorean triples)
$$x^2+y^2=z^2$$
(3,4,5); (5,12,13); (8,15,17) ...  
How about $x^3+y^3=z^3$ ?
* Fermat's conjecture [Fermat's Last Theorem](https://en.wikipedia.org/wiki/Fermat%27s_Last_Theorem)  
For any $n\geqslant 3, x^n+y^n=z^n$ has no solutions over positive integers.  
Proved by [Andrew Wiles](https://en.wikipedia.org/wiki/Andrew_Wiles) in 1994.  
Consider: $P_F$
$$ 
\left\{
             \begin{array}{lr}
             \min_{x,y,z,n}(x^n+y^n-z^n), &  \\
             s.t. \ \ \ \ x\geqslant 1, y \geqslant 1, z \geqslant 1, n \geqslant 3\\
             \sin^2(\pi n)+\sin^2(\pi x)+\sin^2(\pi y)+\sin^2(\pi z)=0 &  
             \end{array}
\right.
$$
<center><img src="src\Lec1-1.PNG"/></center>

If you could certify whether $val(P_F)\not ={0}$, you would have found a proof for Fermat's conjecture.
<center><img src="src\Lec1-2.PNG"/></center>

* Ex: Unconstrainted optimation, many minima:
  "Arbitrary optimization problems are hopeless, we always need some structive"
## Specifying the optimization problem
* Vector space(where the optimization variables and the feasible set "live")  
  $(\mathbb{R}^d, ||\cdot||)$:normed vector space
* Most often, we will take $||x||=||x||_2 = \left(\sum_{i=1}^d x_i^2\right)^{\frac{1}{2}}$
* We might sometimes also consider $l_p$ norms:
$$ ||x||_p = \left(\sum_{i=1}^d x_i^p\right)^{\frac{1}{p}} , p\geqslant 1$$
$$ ||x||_1 = \sum_i |x_i|, ||x||_\infty = \max_{1\leqslant i \leqslant d} |x_i| $$
><center>Updated on 2020/09/04/Friday</center>

