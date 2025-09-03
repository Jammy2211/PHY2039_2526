
## Topics

 * Announcements
 * This week:
	* Recap on differential equations, then on pause
	* Linear algebra

---

## Announcements

* Final assessment:
	* "4 in 24" exam
	* Exam timetable out very soon
	* Mock test out apporox 6th Dec

---

## Where are we?


<table class="table" style="font-size: 0.8em;">
    <tbody>
        <tr >
            <td style="background-color: #ced4d9; text-align: center;" colspan="5"><em><strong>Enrichment week</strong></em></td>
        </tr>
        <tr>
          <td></td>
            <td>7</td>
            <td>15th Nov</td>
            <td>Differential Equations II</td>
            <td></td>
        </tr>
        <tr  style="background-color: #edffab;">
            <td>→</td>
          <td>8</td>
          <td>22nd Nov</td>
            <td>Linear algebra</td>
            <td>Assessment 2 closes 22nd 4pm</td>
        </tr>
        <tr >
            <td></td>
          <td>9</td>
          <td>29th Nov</td>
            <td>Dynamical systems</td>
            <td></td>
        </tr>
        <tr >
            <td></td>
          <td>10</td>
          <td>6th Dec</td>
            <td>Experience week</td>
            <td></td>
        </tr>
        <tr >
            <td></td>
          <td>11</td>
          <td>13th Dec</td>
            <td>Revision / Drop in</td>
            <td></td>
        </tr>
        <tr >
            <td style="background-color: #ced4d9; text-align: center;" colspan="5"><em><strong>Christmas Break</strong></em></td>
        </tr>
        <tr >
            <td></td>
          <td></td>
          <td>10th Jan</td>
            <td>Semester 1 exam period starts</td>
            <td></td>
        </tr>
    </tbody>
</table>

---

## ODE Worked example 

$$ \frac{\mathrm{d}y}{\mathrm{d}t} = \frac{y-5t}{1+t} $$

$y(0) = 3$, $0 \le t \le 4$.

Let's draw a directional field (vector) plot and solve with Euler and Runge-Kutte

---

The directional fields look like this

![](/static/images/week8/illconditioned.png){width=80%}

A small initial change (be it an initial condition or first step) results in being on an entirely different trajectory. 


---

This sort of problem is known as *ill-conditioned*, and in particular this is an issue where, for 

$$ \frac{\mathrm{d}y}{\mathrm{d}t} =f(t,y) $$

where the partial derivative

$$\frac{\partial f(t,y)}{\partial y} > 0 $$

Ill-conditioned problems (as opposed to *well-conditioned*) are particularly unforgiving for the Euler Method and can cause trouble for other methods.

---

## Linear algebra: motivation

As well as this consideration of ill-conditioned problems, we also looked at a stability analysis for one dimensional problems in handout 7. It would be nice to do these things for systems of differential equations.


--- 

## Linear algebra: motivation


It's convenient to treat systems of differential equations like a matrix problem, for example, the Lotka-Volterra equations 

\begin{align}
\frac{\mathrm{d}x}{\mathrm{d}t} &=\alpha x-\beta xy, \\[0.7em] 
\frac{\mathrm{d}y}{\mathrm{d}t} &=\delta xy-\gamma y
\end{align}

can be written:

$$ \frac{\mathrm{d}}{\mathrm{d}t} \begin{pmatrix} x \\ y \end{pmatrix} = \begin{pmatrix} \alpha  & - \beta x \\ \delta y & -\gamma \end{pmatrix} \begin{pmatrix} x \\ y \end{pmatrix}$$


---

## Linear algebra: motivation


And eigenvalue problems are very common in applied maths and physics and it's useful to know how to use Python to solve them.

Example: Time-independent Schrödinger equation from quantum mechanics.

$$ \hat{H}\vec{\psi} = E\vec{\psi} $$


---

## Vectors


$$ 
\vec{v} = \begin{pmatrix} 1 \\ 2 \\ 3 \end{pmatrix}
$$

We can use NumPy arrays to represent a standard vector:

```python
np.array([1, 2, 3])
```

---

## Scalar and vector products

```runnable lang="python"
import numpy as np
a = np.array([1, 2, 3])
b = np.array([4, 5, 6])
```

Let's try out:

* `a*b` 
* `a.b`, 
* `np.dot(a,b)`, 
* `np.cross(a,b)`, 
* `a@b` (the `@` operator is known as the matrix multiplication operator)


--- 

## Matrices

$$ 
\vec{v} = \begin{pmatrix} 1 & 2 \\ 2 & 3 \\ 3 & 4 \end{pmatrix}
$$


```runnable lang="python"
import numpy as np
x = np.array([[1, 2],
              [2, 3],
              [3, 4]])

# Row, column
print(x[1, 1])
```

---

## Matrix Products

```runnable lang="python"
import numpy as np
A = np.array([[1, 2],
              [2, 3],
              [3, 4]])
B = np.array([[4, 5],
              [5, 6],
              [6, 7]])
```

Let's try out:

* `A*B` 
* `A.B`, 
* `np.dot(A,B)`, 
* `np.cross(A,B)`, 
* `A@B`


---

## Scipy `linalg`

```runnable lang="python"
import numpy as np
import scipy.linalg as sla
A = np.array([[1, 0, 3],
              [2, 1, 1],
              [1, 0, 1]])
```

Let's try out:

* `sla.det`
* `sla.inv`

---

## Linear System of Equations

$$ \mathbf{A}\vec{x} = \vec{b} $$

* Solve simultaneous equations! $n$ equations in $n$ unknowns.

$$
\begin{matrix}
x + 2y = 5 \\
2x + y = 7
\end{matrix} \quad \rightarrow \quad
\begin{pmatrix}
1 & 2 \\ 2 & 1
\end{pmatrix}
\begin{pmatrix}
x \\ y
\end{pmatrix}
=
\begin{pmatrix}
5 \\ 7
\end{pmatrix}
$$

```python
sla.solve(A, b)
```

Returns the vector `x` with the unknowns in order

---

## Eigenvalues and Eigenvectors

Obtain solutions to the equation

$$ \mathbf{A}\vec{x} = \lambda\vec{x} $$

where $\lambda$ is a scalar

```python
sla.eig(A)
```

Returns a "tuple" (two values): unpack with e.g.

```python
eigenvalues, eigenvectors = sla.eig(A)
```


---

## Summary

There's plenty to try out in the practical this week. We'll look at how to use these methods and more for creating and manipulating matrices, before returning to look further at dynamical systems represented by differential equations next week.
