## Topics

 * Announcements
 * This week:
	* Recap on odeint
 	* Visualising solutions with quiver plots
 	* Euler Method
    * Runge-Kutta Methods

 ---

## Announcements


 * Assessment 2 is due 4pm Monday 22nd November

 . . .

 * Exam timetable out very soon

---

## Where are we?


<table class="table" style="font-size: 0.8em;">
    <tbody>
        <tr >
            <td style="background-color: #ced4d9; text-align: center;" colspan="5"><em><strong>Enrichment week</strong></em></td>
        </tr>
        <tr  style="background-color: #edffab;">
          <td>→</td>
            <td>7</td>
            <td>15th Nov</td>
            <td>Differential Equations II</td>
            <td></td>
        </tr>
        <tr >
            <td></td>
          <td>8</td>
          <td>22nd Nov</td>
            <td>Dynamical systems</td>
            <td>Assessment 2 closes 22nd 4pm</td>
        </tr>
        <tr >
            <td></td>
          <td>9</td>
          <td>29th Nov</td>
            <td>Linear algebra</td>
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

## Recap: odeint

```python
import numpy as np
import matplotlib.pyplot as plt 
from scipy.integrate import odeint

# t array
t = np.linspace(0,5,100)
# initial value
y0 = 5
# solve with odeint
y = odeint(lambda y,t: -y/2,y0,t)
# plot
plt.plot(t,y[:,0])
```

---

## Visualising solutions with quiver plots

$$ \frac{\mathrm{d}y}{\mathrm{d}t}=-\frac{y}{2}$$

Let $\mathrm{d}t=1$, then $\displaystyle \mathrm{d}y=-\frac{y}{2}$ (the change in one unit of $t$). Turn this into quiver plot components:

. . .

![Directional field plot for dy/dt = -y/2](/static/images/week8/directional1.png){width=70%}

---

```python
import numpy as np
import matplotlib.pyplot as plt 

t = np.arange(0, 5, 0.25)
y = np.arange(-6, 6, 0.5)
T, Y = np.meshgrid(t, y)

DT = np.ones(T.shape)  
DY = -Y/2

plt.quiver(T, Y, DT, DY, angles='xy')
```

----

### The Euler Method


This week we look at using the Euler Method to solve our initial value problem

$$ \frac{dy}{dt}=-\frac{y}{2}, \quad y(0)=5 $$



### &nbsp; {: data-transition="none"}

$$ \frac{dy}{dt}=-\frac{y}{2}, \quad y(0)=5 $$

![](/static/images/week6/explanation0.png){style="margin: 0; width: 80%;"}


What's our goal?

### &nbsp; {: data-transition="none"}
$$ \frac{dy}{dt}=-\frac{y}{2}, \quad y(0)=5 $$
![](/static/images/week6/explanation1.png){style="margin: 0; width: 80%;"}

We want to know how $y$ evolves with $t$.

### &nbsp; {: data-transition="none"}
$$ \frac{dy}{dt}=-\frac{y}{2}, \quad y(0)=5 $$
![](/static/images/week6/explanation0.png){style="margin: 0; width: 80%;"}

What do we know?

### &nbsp; {: data-transition="none"}
$$ \frac{dy}{dt}=-\frac{y}{2}, \quad y(0)=5 $$ 
![](/static/images/week6/explanation2.png){style="margin: 0; width: 80%;"}

$$y(0)=5$$

### &nbsp; {: data-transition="none"}
$$ \frac{dy}{dt}=-\frac{y}{2}, \quad y(0)=5 $$
![](/static/images/week6/explanation3.png){style="margin: 0; width: 80%;"}

$$\frac{\mathrm{d}y}{\mathrm{d}t}(0)=-\frac{5}{2}$$

### &nbsp; {: data-transition="none"}
$$ \frac{dy}{dt}=-\frac{y}{2}, \quad y(0)=5 $$
![](/static/images/week6/explanation4.png){style="margin: 0; width: 80%;"}

Suppose we use this to estimate the position of $y(1)$



### &nbsp; {: data-transition="none"}
$$ \frac{dy}{dt}=-\frac{y}{2}, \quad y(0)=5 $$
![](/static/images/week6/explanation5.png){style="margin: 0; width: 80%;"}

$y(1) = 5 -\left(\frac{5}{2}\right)h$, where $h$ is the separation in $t$



### &nbsp; {: data-transition="none"}
$$ \frac{dy}{dt}=-\frac{y}{2}, \quad y(0)=5 $$
![](/static/images/week6/explanation6.png){style="margin: 0; width: 80%;"}

$$y(1) = \frac{5}{2}$$



### &nbsp; {: data-transition="none"}
$$ \frac{dy}{dt}=-\frac{y}{2}, \quad y(0)=5 $$
![](/static/images/week6/explanation7.png){style="margin: 0; width: 80%;"}

$$\frac{\mathrm{d}y}{\mathrm{d}t}\left(\frac{5}{2}\right)=-\frac{5}{4}$$
 


### &nbsp; {: data-transition="none"}
$$ \frac{dy}{dt}=-\frac{y}{2}, \quad y(0)=5 $$
![](/static/images/week6/explanation8.png){style="margin: 0; width: 80%;"}

And so on...


 
### &nbsp; {: data-transition="none"}
$$ \frac{dy}{dt}=-\frac{y}{2}, \quad y(0)=5 $$
![](/static/images/week6/explanation9.png){style="margin: 0; width: 80%;"}

And so on...

 
### &nbsp; {: data-transition="none"}
$$ \frac{dy}{dt}=-\frac{y}{2}, \quad y(0)=5 $$
![](/static/images/week6/explanation10.png){style="margin: 0; width: 80%;"}

And so on...

 
### &nbsp; {: data-transition="none"}
$$ \frac{dy}{dt}=-\frac{y}{2}, \quad y(0)=5 $$
![](/static/images/week6/explanation10.png){style="margin: 0; width: 80%;"}

And so on...

 
### &nbsp; {: data-transition="none"}
$$ \frac{dy}{dt}=-\frac{y}{2}, \quad y(0)=5 $$
![](/static/images/week6/explanation11.png){style="margin: 0; width: 80%;"}

And so on...

 
### &nbsp; {: data-transition="none"}
$$ \frac{dy}{dt}=-\frac{y}{2}, \quad y(0)=5 $$
![](/static/images/week6/explanation12.png){style="margin: 0; width: 80%;"}

And so on...

 
### &nbsp; {: data-transition="none"}
$$ \frac{dy}{dt}=-\frac{y}{2}, \quad y(0)=5 $$
![](/static/images/week6/explanation13.png){style="margin: 0; width: 80%;"}

And so on...

 
### &nbsp; {: data-transition="none"}
$$ \frac{dy}{dt}=-\frac{y}{2}, \quad y(0)=5 $$
![](/static/images/week6/explanation14.png){style="margin: 0; width: 80%;"}

And so on...

 
### &nbsp; {: data-transition="none"}
$$ \frac{dy}{dt}=-\frac{y}{2}, \quad y(0)=5 $$
![](/static/images/week6/explanation15.png){style="margin: 0; width: 80%;"}

And so on...

### &nbsp; {: data-transition="none"}
$$ \frac{dy}{dt}=-\frac{y}{2}, \quad y(0)=5 $$
![](/static/images/week6/explanation16.png){style="margin: 0; width: 80%;"}

And so on...

### &nbsp; {: data-transition="none"}
$$ \frac{dy}{dt}=-\frac{y}{2}, \quad y(0)=5 $$
![](/static/images/week6/explanation17.png){style="margin: 0; width: 80%;"}

And so on...

### &nbsp; {: data-transition="none"}
$$ \frac{dy}{dt}=-\frac{y}{2}, \quad y(0)=5 $$
![](/static/images/week6/explanation18.png){style="margin: 0; width: 80%;"}

And so on...

### &nbsp; {: data-transition="none"}
$$ \frac{dy}{dt}=-\frac{y}{2}, \quad y(0)=5 $$
![](/static/images/week6/explanation19.png){style="margin: 0; width: 80%;"}

And so on...


---

An animation. Why not?!

![](/static/images/week6/euler.gif){style="margin: 0; width: 80%;"}

----

In equation form, for an equation

$$ \frac{\mathrm{d}y}{\mathrm{d}t} = f(y,t). $$

The Euler Method is

$$ \displaystyle y_{n+1} = y_{n} + h f(y_n,t_n). $$


---

How does this compare to the exact solution?

---

$h = 1$

![](/static/images/week6/h1.png){style="margin: 0; width: 80%;"}

---

$h = 0.5$

![](/static/images/week6/h0p5.png){style="margin: 0; width: 80%;"}

---

$h = 0.25$

![](/static/images/week6/h0p25.png){style="margin: 0; width: 80%;"}

---

![](/static/images/week6/euler_animation.gif){style="margin: 0; width: 80%;"}

----

### Logistic equation

Let's apply the Euler Method to the logistic equation

$$ \frac{\mathrm{d}x}{\mathrm{d}t}=rx(1-x)\text{.}$$

$x(t)$ is the proportion of a maximum population density at time $t$, i.e. it takes values in the interval $[0,1]$, and the constant $r$ defines the growth rate.

---

![](/static/images/week6/logistic_family.png){width=80%}


---

## Runge-Kutta Methods

The "Classic Runge-Kutta Method" (sometimes just Runge-Kutte Method or RK4 (for 4th order)) solves

\[ \frac{\mathrm{d}y}{\mathrm{d}t}=f(t,y) ,\quad y(0) = y_0\] 

using the iterative formula

\[ y_{n+1}=y_{n}+\frac{1}{6}h\left(k_1+2k_2+2k_3+k_4\right), \]

---

where 

\[
\begin{align}
k_1 &= f(t_n,y_n), \\[0.7em]
k_2 &= f\left(t_n+\frac{h}{2},y_n+h\frac{k_1}{2}\right), \\[0.7em]
k_3 &= f\left(t_n+\frac{h}{2},y_n+h\frac{k_2}{2}\right), \\[0.7em]
k_4 &= f\left(t_n+h,y_n+hk_3\right).
\end{align}
\]

---

![](/static/images/week7/runge-kutta-1.png){width=80%}

---

## Summary

This week we look at algorithms to solve differential equations, including a closer look at how to quantify the **accuracy** and **stability** of numerical methods.

