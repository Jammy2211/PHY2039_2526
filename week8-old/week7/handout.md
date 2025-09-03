
## Recap: odeint

Last time out we solved first order and systems of ODEs using the SciPy function `odeint`.

```python
import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import odeint

# function on the rhs of dy/dt
def rhs(y,t):
    dydt = - y/2
    return dydt

# initial condition
y0 = 5

# t array
t = np.linspace(0,5,100)

# solve ODE
y = odeint(rhs,y0,t)

# plot results
plt.plot(t,y)
plt.xlabel('t')
plt.ylabel('y(t)')
```

This week we build on this by looking at the underlying algorithms.


## The Euler Method


Let's look at the simplest algorithm for solving an initial value problem like 

$$ \frac{dy}{dt}=-\frac{y}{2}, \quad y(0)=5 $$

which is the Euler Method (sometimes Euler's Method).

The idea behind the method is that we can use what we know about $y$ at $t = 0$. That is: 

1) $y(0)=5$ 

2) $\displaystyle \frac{\mathrm{d}y}{\mathrm{d}t}(0)=-\frac{5}{2}$

![](/static/images/week6/explanation3.png){width=80%}


to estimate $y$ at some later point

![](/static/images/week6/explanation5.png){width=80%}

At each step, the gradient is by definition the right hand side of

$$ \frac{dy}{dt}=-\frac{y}{2} $$


So for a point $y_n$, the next point is given by

$$y_{n+1} = y_{n} + \left(-\frac{y_n}{2}\right)h $$

where the separation between the points is $h$ (in the image above, $h = 1$)

![Euler Method animation](/static/images/week6/euler.gif){width=80%}


If these were values in arrays `y` and `t` then this might look like

```python
y[1] = y[0] + (-y[0]/2)*h
```
where I have purposefully added brackets to emphasise that the `(-2/y)` to note that this comes from the right hand side of the differential equation.

### Euler Method in Python

Let's take a look at how to put this in Python.

<!--<iframe src="https://campus.recap.ncl.ac.uk/Panopto/Pages/Embed.aspx?id=13f6eddf-7c40-4c9b-89b4-ac89012cba27&autoplay=false&offerviewer=true&showtitle=true&showbrand=false&start=0&interactivity=all" width=720 height=405 style="border: 1px solid #464646;" allowfullscreen allow="autoplay"></iframe>-->

Suppose that we have an array of $t$ values at which we are interested in finding $y(t)$. In this case the integers $[0,1,2,3,5]$.

```python
t = np.arange(0,6)
```

Then let's create an empty array of the same length for $y(t)$ (as we want one y value for each t value)

```python
y = np.zeros(len(t))
```

We already know that the first value of `y` is 5 (for our example):

```python
y[0] = 5
```

Since $\displaystyle \frac{\mathrm{d}y}{\mathrm{d}t}(0)=-\frac{5}{2}$, the value at $t = 1$ was given by 

$$y(1) = 5 -\left(\frac{5}{2}(1-0)\right)$$

```python
y[1] = y[0] + (-y[0]/2)*h
```

The next point is then

```python
y[2] = y[1] + (-y[1]/2)*h
```

and so on.


In equation form, for 

$$ \frac{\mathrm{d}y}{\mathrm{d}t} = f(y,t). $$

Euler's method is

$$ y_{n+1} = y_{n} + h f(y_n,t_n). $$

As a full piece of code, the solution to our introductory probably can be found with


```python
import numpy as np
import matplotlib.pyplot as plt

# Change t to adjust the accuracy
t = np.linspace(0,5,10)
y = np.zeros(len(t))
h = t[1]-t[0]

y[0] = 5

for n in range(len(t)-1):
    y[n+1] = y[n] + h * (- y[n]/2)

plt.plot(t,y,'-o')

```

### Accuracy of the Euler Method

The exact solution can be found using separation of variables as follows:

$$ \frac{dy}{dt}=-\frac{y}{2} $$

Separate all of the $y$ stuff to one side, all the $t$ stuff to the other and integrate:

$$ \int \frac{dy}{y}= -\int\frac{dt}{2} $$

this gives

$$ log(y) = -\frac{t}{2} + c $$

take the exponential of both sides

$$ y = e^{-t/2 + c} = e^ce^{-t/2} = Ae^{-t/2} $$

where $A = e^c$ is a constant to be determined.

Since we know that $y(0) = 5$,

$$ 5 = Ae^0 = A $$

so the solution to the initial value problem is 

$$ y(t) = 5e^{-t/2}. $$

We can add this to our plot (at the end of the previous code) as follows:

```python
t1 = np.linspace(0,5,100)
plt.plot(t1,5*np.exp(-t1/2))
plt.legend(['Euler Method','Exact solution'])
```

The accuracy of the Euler Method increases as $h$ is reduced, as illustrated in the following animation:

![](/static/images/week6/euler_animation.gif){width=80%}

Have a go at this yourself, by changing the `t` array in the code above.

Quantifying the accuracy of the method is something that we will look at later on.

### Exercise 7.1 {: .exercise }

In this exercise we'll adapt the code above to solve a similar problem.

<numbas-embed data-url="https://numbas.mathcentre.ac.uk/question/81775/euler-method-adapt-existing/embed/?token=5dc5cf01-1b69-403a-bef7-b2f798c6fae1" data-id="exercise-7-1" data-cta="Show Exercise"></numbas-embed>




### Euler Method function


<!--<iframe src="https://campus.recap.ncl.ac.uk/Panopto/Pages/Embed.aspx?id=d509f914-dc0c-40c9-86be-ac89012cb9bb&autoplay=false&offerviewer=true&showtitle=true&showbrand=false&start=0&interactivity=all" width=720 height=405 style="border: 1px solid #464646;" allowfullscreen allow="autoplay"></iframe>-->

Let's place this into a function...

The function `euler`  can accept any function `f(y,t)` as input (the right hand side of a differential equation - which could depend on $t$ and $y$, along with an initial value and a t array.


```python
def euler(f,y0,t):
	"""
	Returns the solution y(t) for an initial value problem
	dy/dt = f(y,t)
	for an array t and initial value y0
	"""

    y = np.zeros(len(t))   
    y[0] = y0            

    for n in range(0,len(t)-1):
        y[n+1] = y[n] + f(y[n],t[n])*(t[n+1]-t[n])
        
    return y
```

Note that I've replaced `h` with `(t[n+1]-t[n])`. Although I could set something like `h = t[1]-t[0]`, it would only be correct if `t` is a linearly spaced array. Using `(t[n+1]-t[n])` would accommodate an array which is not linearly spaced, say `t=[0,1,2,5]`, if we had motivation to do such a thing.

This can be called with the following. Note I've exaggerated the fact that the function we're sending is the right side of the differential equation by calling it `rhs`.

```python
t = np.linspace(0,10,20)
y0 = 5

def rhs(y,t):
    return -y/2

y = euler(rhs,y0,t)
plt.plot(t,y)
```

or using a lambda function:

```python
t = np.arange(0,5)
y0 = 5
y = euler(lambda y,t: -y/2, y0, t)
plt.plot(t,y)
```

### Dependence on t

`t` here is our independant variable and in writing the code above, we have accomodated $t$ appearing on the right hand side of the differential equation. Consider the initial value problem


$$ \frac{dy}{dt}=yt,\quad y(0)=1 $$

This requires no change to our `euler` function. We can just add the `t` dependance into our `rhs` function.

```python
t = np.linspace(0,10,20)
y0 = 1

def rhs(y,t):
    return t*y

y = euler(rhs,y0,t)
# or y = euler(lambda t,y: t*y, y0, t)
```

### Exercise 7.2 {: .exercise }

Here's a more interesting example for $f(t,y)$ depending on both $t$ and $y$, and one where the Euler Method struggles, primarily because the function oscillates rapidly. Try changing the `t` array, as suggested in the exercise, to see that even with a very fine grid of values (try 1000 or more!), the method does not do a great job. 

<numbas-embed data-url="https://numbas.mathcentre.ac.uk/question/82104/euler-method-adapt-existing-function/embed/?token=ec57777a-1cf7-4f44-a411-7f5612a157bf" data-id="exercise-7-2" data-cta="Show Exercise"></numbas-embed>



### Re-writing to vary $h$

Let's re-write this code slightly, as we're interested in particular in the value $h = (t_{n+1}-t_n)$, the step-size.

```python
import numpy as np
import matplotlib.pyplot as plt

tmax = 5
h = 0.25
t = np.arange(0,tmax+h,h)
y0 = 1

def rhs(y,t):
    return -2*y

y = euler(rhs,y0,t)
plt.plot(t,y)
```

## Truncation errors

The errors associated with using a numerical approximation in our approach are known as **truncation errors** and are quantified in two different ways: Local Truncation Error (LTE) associated with errors in a single step and Global Truncation Error (GTE) associated with cumulative errors. Let's look at each in turn:

### Local truncation error

The *local truncation error* (LTE) is the error associated with a single step between, say, $y_0 = y(t_0)$ and $y_1 = y(t_1)$.

Consider the Taylor Expansion

$$ y_1 = y(t_{0}+h)=y(t_{0})+hy'(t_{0})+{\frac {1}{2}}h^{2}y''(t_{0})+\mathcal{O}(h^{3}) $$

where $\displaystyle y' = \frac{\mathrm{d}y}{\mathrm{d}t} = f(t,y)$ by definition. So the exact solution to $y_1$ is

$$ y_1 = y_0 +hf(t_0,y_0)+O(h^{2}) $$

By comparison, our algorithm for the Euler Method is 

$$ y_1 = y_0 +hf(t_0,y_0)$$

The error in each step is therefore $\mathcal{O}(h^{2})$.

<!--<iframe src="https://campus.recap.ncl.ac.uk/Panopto/Pages/Embed.aspx?id=a2ef5c5f-2a1f-4bec-bebf-ac9000ee752f&autoplay=false&offerviewer=true&showtitle=true&showbrand=false&start=0&interactivity=all" width=720 height=405 style="border: 1px solid #464646;" allowfullscreen allow="autoplay"></iframe>-->

Let's investigate this with a single step of the Euler Method for our initial value problem:

```python
def rhs(y,t):
    return -2*y

h = 0.25
y0 = 1
t0 = 0
t1 = t0+h

# Euler solution using
y1_euler = y0 + h*rhs(y0,t0)
y1_exact = np.exp(-2*t1)
```

The LTE is given by `y1_euler - y1_exact`, which is $-0.11$ here. 

We might expect to get a quadratic if we vary $h$. Let's take a look. I've chosen to take the absolute difference for the errors using `abs`.

```python
import numpy as np
import matplotlib.pyplot as plt

def rhs(y,t):
    return -2*y

h_values = [0.01,0.05,0.1,0.15,0.20,0.25,0.3,0.35,0.4]
errors = []
y0 = 1

for h in h_values:
    y1_euler = y0 + h*rhs(y0,0)
    y1_exact = np.exp(-2*h)
    errors.append(abs(y1_exact - y1_euler))
    
    
plt.plot(h_values,errors,'-o')
```

![Plot of the local truncation error against stepsize h](/static/images/week8/lte.png){width=80%}

### Global truncation error

The *global truncation error* (GTE) is the cumulative error after some time $t$.

In other words it is the difference between the exact value for $y(t)$ and our Euler approximation $y(t_n)$. 

At some time $t$, the number of steps that have been carried out is given by $(t-t_0)/h$ (proportional to $1/h$). Since the LTE at each step is proportional to $h^{2}$, we can expect that the global truncation error will be proportional to $h$. The Euler Method is often therefore considered an $\mathcal{O}(h)$ method. 

In practice the global truncation error depends on the local truncation errors, which can vary across a range $[t_0,t]$ (noting in particular the presence of $y''$ in the Taylor expansion, which may change signficantly over time). 

By comparison, the classic Runge-Kutta Method we will look at later is $\mathcal{O}(h^4)$.


## Stability

<!--<iframe src="https://campus.recap.ncl.ac.uk/Panopto/Pages/Embed.aspx?id=6c419247-b8fb-4241-b319-ac9000ee520d&autoplay=false&offerviewer=true&showtitle=true&showbrand=false&start=0&interactivity=all" width=720 height=405 style="border: 1px solid #464646;" allowfullscreen allow="autoplay"></iframe>-->

Going back to our earlier example, with $y(0)=1$ for simplicity,

$$\frac{\mathrm{d}y}{\mathrm{d}t} = -2y, \quad y(0) = 1$$

We note that the exact solution $y(t) = e^{-2t} \to 0$, as $t \to \infty$.

Consider values $h = 0.25, 0.5, 1, 1.25$

```python
import numpy as np
import matplotlib.pyplot as plt

def rhs(y,t):
    return -2*y


y0 = 1
tmax = 5
h_values = [0.25,0.5,1,1.25]

leg = []

for h in h_values: 
    
    t = np.arange(0,tmax+h,h)
    y = euler(rhs,y0,t)
    
    plt.plot(t,y,'-o')
    leg.append('h = {}'.format(h))

plt.legend(leg)
plt.xlabel('t')
plt.ylabel('y(t)')
```

![Plot of the Euler Solution with h = 0.1, 0.5, 1.0, 1.25](/static/images/week8/unstable.png){width=80%}

The solution is numerically unstable beyond a critical value of $h$. Continuing the $t$ range for $h = 1.25$.

![Plot of the Euler Solution with h = 1.25](/static/images/week8/blownup.png){width=80%}

the solution continues to grow (recall that $y$ is supposed to be tending to zero!!). At $t = 200$, $y(t)$ is $1.5 \times 10^{28}$...! 

So why does this happen?

Consider our equation again. We know that

$$y_{n+1} = y_n - 2hy_n = (1-2h)y_n$$

Since $y_n = (1-2h)y_{n-1}$, we have

$$ y_{n+1} = y_n - 2hy_n = (1-2h)y_n = (1-2h)^2y_{n-1} $$

Extending the idea further,

$$ y_{n+1} =  (1-2h)^{n+1} y_0. $$

This implies that $y_n \to 0$ as $t\to\infty$, only if $|1-2h|\lt 1$, or, rearranging, $h \lt 1$.

 Here's a plot of $h = 0.95, 1.0, 1.05$ to illustrate.

![Plot of the Euler Solution with h = 0.95, 1.0, 1.05](/static/images/week8/critical.png){width=80%}

The conclusion is that there exists a critical step size for the Euler Method to be successful. In this case it is $h=1$.

### Exercise 7.3 {: .exercise}

We didn't see any of these stability issues when we experimented with the step size for our first test problem, which was

$$ \frac{\mathrm{d}y}{\mathrm{d}t} = -\frac{y}{2}, y(0) = 5$$

Did we miss them? Let's find out...


<numbas-embed data-url="https://numbas.mathcentre.ac.uk/question/83998/stability-of-euler-method-for-dy-dx-y-2/embed/?token=c0cccc44-fe65-4c76-b671-9d644e98d792" data-id="exercise-7-3" data-cta="Show Exercise"></numbas-embed>





## Euler Method with a system of ODEs

Let's revisit the SIR model from week 6:

\begin{align}
\frac{dS}{dt}&=-\beta IS, \\
\frac{dI}{dt}&=\beta IS -\gamma I \\
\frac{dR}{dt}&= \gamma I
\end{align}

Expanding the Euler Method for a system of ODEs just means stepping forward $S$, $I$ and $R$ at each iteration:

```python
import numpy as np
import matplotlib.pyplot as plt

# Initialise arrays
t = np.linspace(0,20,50)
S = np.zeros(len(t))
I = np.zeros(len(t))
R = np.zeros(len(t))

# Initial conditions
S[0] = 999
I[0] = 1
R[0] = 0

# Parameters
b = 0.002
c = 0.5

for n in range(len(t)-1):
    S[n+1] = S[n] + (t[n+1]-t[n]) * (-b*I[n]*S[n])
    I[n+1] = I[n] + (t[n+1]-t[n]) * (b*I[n]*S[n] - c*I[n])
    R[n+1] = R[n] + (t[n+1]-t[n]) * (c*I[n])

# Make a plot
plt.plot(t,S)
plt.plot(t,I)
plt.plot(t,R)
plt.xlabel('t')
plt.title('SIR Model with the Euler Method')
plt.legend(['S(t)','I(t)','R(t)'])
```


### Exercise 7.4 {: .exercise}

<button class="btn btn-primary toggle" type="button" data-toggle="collapse" data-target="#exercise3" aria-expanded="false" aria-controls="exercise3">
<span id="txt">Show</span> exercise >
</button> 
<div class="collapse" id="exercise3">
Copy the code above into Python and verify that you obtain a similar plot to week 6.
<img src="/static/images/week7/sir.png" alt="SIR Model" style="width: 100%; max-width: 700px; margin: 20px 0;"/>
<p>Investigate changing the step size to have less points in <code>t</code>. You should find that the method becomes **unstable** for larger step sizes (try e.g. 12 values in <code>t</code>).</p>
</div>

### Exercise 7.5 {: .exercise}


<numbas-embed data-url="https://numbas.mathcentre.ac.uk/question/83147/lotka-volterra-euler-method/embed/?token=127848d8-83fd-4f19-a6e5-ed411d26c120" data-id="exercise-7-5" data-cta="Show Exercise"></numbas-embed>



## Runge-Kutte Methods

Euler's method can be improved upon by more carefully advancing from a known $y_n$ to $y_{n+1}$. One way to do this is to first make a trial half-step forward, from $t_0$ to $t_0 + h/2$, find $y(t_0 + h/2)$ and use this to move forward to $y(t_1)$. The idea is that the gradient midway between $t_0$ and $t_1$ will be a better representation of the function in this interval than the gradient at one end.

This method turns out to be more stable and accurate than Euler’s method. One can immediately propose to make more trial steps to improve accuracy, bearing in mind that each intermediate step means more time and effort: as we've talked about elsewhere, there is a trade off between speed and precision.

Schemes which adopt this approach to computing numerical solutions to ODEs are called **Runge-Kutta methods**. A popular algorithm is the fourth-order Runge-Kutta scheme, which makes four evaluations of $\mathrm{d}y/\mathrm{d}t$: once at the starting point, two trials at the midpoint and one trial at the end, to advance each step.

### Classic Runge-Kutte Method

The "Classic Runge-Kutta Method" (sometimes just Runge-Kutte Method or RK4 (for fourth order)) solves

\[ \frac{\mathrm{d}y}{\mathrm{d}t}=f(t,y) ,\quad y(0) = y_0\] 

using the iterative formula

\[ y_{n+1}=y_{n}+\frac{1}{6}h\left(k_1+2k_2+2k_3+k_4\right), \]

where 

\[
\begin{align}
k_1 &= f(t_n,y_n), \\[0.7em]
k_2 &= f\left(t_n+\frac{h}{2},y_n+h\frac{k_1}{2}\right), \\[0.7em]
k_3 &= f\left(t_n+\frac{h}{2},y_n+h\frac{k_2}{2}\right), \\[0.7em]
k_4 &= f\left(t_n+h,y_n+hk_3\right).
\end{align}
\]

The method offers a significant improvement on the Euler Method:

![](/static/images/week7/runge-kutta-1.png){width=80%}

### Exercise 7.6 {: .exercise}

Let's have a go at coding this up.


<numbas-embed data-url="https://numbas.mathcentre.ac.uk/question/82425/runge-kutta-method/embed/?token=e5c1d5bd-c2ea-46f2-9e94-579d35e787d7" data-id="exercise-7-6" data-cta="Show Exercise"></numbas-embed>



## Visualising solutions with vector plots


Consider again our ODE

$$ \frac{\mathrm{d}y}{\mathrm{d}t} = -\frac{y}{2} $$

Numerical methods to solve ODEs are based on the idea that the solution close to a known point $y(t_0)$ can be estimated by using the tangent line to $y(t)$ at $t_0$. Since the right hand side gives the derivative of $y(t)$, we can apply this idea to plot the *direction field* of an ODE. This will show the trajectories of solutions. 

Constructing a direction field by hand is straightforward but it is also time-consuming and repetitive: exactly the sort of problem a computer is good for! 

The following figure shows the direction field for the above ODE.

![Directional field plot for dy/dt = -y/2](/static/images/week8/directional1.png){width=90%}

The Matplotlib plotting function `quiver` is used to plot these arrows. 

Before we do that, a 2D grid of points needs to be defined. This can be done as follows:

```python
import numpy as np
import matplotlib.pyplot as plt 

t = np.arange(0, 5, 0.25)
y = np.arange(-6, 6, 0.5)
T, Y = np.meshgrid(t, y)
```

I've chosen those ranges and step-sizes fairly arbitrarily, feel free to play around with them.

Now we can create the vector components: we can choose $\mathrm{d}t = 1$ and then from the ODE above, $\mathrm{d}y = -y/2$:

```python
DT = np.ones(T.shape)   # T.shape just gives the dimensions of T
DY = -Y/2

plt.quiver(T, Y, DT, DY, angles='xy')
```

To see what the function `np.ones` does then try out, for example

```python
np.ones(5)
np.ones([2,5])
```

Let's also add two solution curves for $y(0)=5$ and $y(0)=-5$

```python
# I've changed the arrow style using
# plt.quiver(T,Y,DT,DY, angles='xy',color='gray',width=0.002)

t = np.linspace(0,5,100)
y = euler(rhs,5,t)
plt.plot(t,y)

y = euler(rhs,-5,t)
plt.plot(t,y)

plt.legend(['y(0)=5','y(0)=-5'])
```

![Directional field plot for dy/dt = -y/2 with solutions y(0)=5 and y(0)=-5](/static/images/week8/directional2.png){width=90%}


### Exercise 7.7  {: .exercise}

Here's an exercise to have a go at this.

<numbas-embed data-url="https://numbas.mathcentre.ac.uk/question/83999/quiver-plot/embed/?token=c7e66cc1-3b21-4a0c-81f8-1d8222c5525a" data-id="exercise-7-7" data-cta="Show Exercise"></numbas-embed>

## Summary

We've covered a lot of ground today. Next week we'll build on this by looking at some very specific and interesting applications of these ideas in more depth.
