# Differential Equations of Love and Love of Differential Equations

In this option for the practical you're going to do some reading, and optionally try out coding up the equations.

The reading of an actual scientific paper in itself is a useful task, to see the structure, the layout, the style. Though this is far from your ordinary scientific paper

Here's the paper... It's a very tongue in cheek attempt to code up the equations of love, starting with Romeo and Juliet. I think in particular it's a fun way to see where the coefficients and sign of terms in differential equations originate from, to go beyond them just being symbols on a page.

<a class="btn btn-primary" target="_blank" href="https://scholarship.claremont.edu/cgi/viewcontent.cgi?article=1549&context=jhm">❤️ View the paper ❤️</a>

In the paper, the author solves most of the differential equations exactly, however they are fun to put into Python for some `odeint` practice. For example, the original equations for Romeo ($R$) and Juliet ($J$)'s hyperbolic love 

\[
\begin{align}
\frac{\mathrm{d}R}{\mathrm{d}t} &= aJ \\
\frac{\mathrm{d}J}{\mathrm{d}t} &= bR \\
\end{align}
\]

with $a = 5$, $b=2$, $R(0)=1$, $J(0)=0$,

```python
import numpy as np
from scipy.integrate import odeint
import matplotlib.pyplot as plt

def model(y, t, a,b):
    R, J = y            
    dRdt = a*J   
    dJdt = b*R  
    return [dRdt, dJdt]   

# Parameters
a = 5
b = 2

# Initial conditions
y0 = [1,0]

# Time points
t = np.linspace(0,1,100)

# Solve ODE
y = odeint(model,y0,t, args=(a,b))

plt.plot(t,y)
plt.legend(['Romeo','Juliet'])
plt.xlabel('t')
plt.title('Evolution of the Romeo and Juliet relationship')
```

![Romeo and Juliet](/static/images/week10/romeojuliet.png){width=65%}

Go ahead and try coding up (or solving by hand) some of the others, making some of the changes in parameters suggested in the paper, and so on...

Hope you enjoy!

