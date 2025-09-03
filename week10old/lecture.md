
## Topics

 * Plan for this week
 * Exam arrangements and mock test

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
        <tr>
            <td></td>
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
        <tr  style="background-color: #edffab;" >
            <td>→</td>
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
            <td>Semester 1 exam: 13th January</td>
            <td></td>
        </tr>
    </tbody>
</table>

---

## Announcements

* I'm still marking assignment 2!

. . .

* Optional practical today!

. . .

* Practical Thursday/Friday

. . .

* Final assessment:
    * "4 in 24" exam
    * 13th January 9:30
    * Mock test 

---

## What does the future hold?

. . .

### Boundary value problems

![Boundary conditions](/static/images/week10/bcs.png){width=70%}


You'll meet Boundary Value Problems (MAS2804/PHY2034 semester 2), which can be solved using `solve_bvp` (similar to `odeint`)

---

### Series solutions (see mock question 5)

![Boundary conditions](/static/images/week10/series.gif){width=80%}

---

### Partial differential equations

\[ \frac{\partial c}{\partial t}=\mathbf {\nabla } \cdot (D\mathbf {\nabla } c)-\mathbf {\nabla } \cdot (\mathbf {v} c)+R\]

Much more complicated. Several open source solvers, for example FEniCS, PyCC, SyFi.

---

## Serial vs Parallel Programming

So far we have been limited by the processing power of our device.

Real scientific research typically takes advantage of *parallelisation* to make use of multiple processors, typically spread across a supercomputer.

---

### Serial programming

![Serial programming](/static/images/week10/serial.png){width=60%}

---

### Parallel programming

![Parallel programming](/static/images/week10/parallel.png){width=80%}

---

![HPC](/static/images/week10/hpc.jpg){width=80%}

---

Basic example

```python
from joblib import Parallel, delayed

n = 1000

def func(i):
    s = 0
    for j in range(i):
        s += j
    return s

Parallel(n_jobs=4)(delayed(func)(i) for i in range(n))
```

----

## Mock test

Let's have a go at some questions from the mock test.
