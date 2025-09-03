
## Ill-conditioned problems

In this video, I create the directional field plot in this section.

<iframe src="https://campus.recap.ncl.ac.uk/Panopto/Pages/Embed.aspx?id=7b02ab52-a9c7-4c2d-9889-ac9000ee2d2a&autoplay=false&offerviewer=true&showtitle=true&showbrand=false&start=0&interactivity=all" width=720 height=405 style="border: 1px solid #464646;" allowfullscreen allow="autoplay"></iframe>

The directional fields in the last section allow us to visualise another issue with the Euler Method. Consider the problem

$$ \frac{\mathrm{d}y}{\mathrm{d}t} = \frac{y-5t}{1+t}, \quad y(0) = 3 $$

The directional fields look like this

![](/static/images/week8/illconditioned.png){width=90%}

The exact solution is added (it is $y(t) = 3 + 8t - 5(1 + t)\log(1 + t)$ - you can take my word for it). 

The issue with the Euler Method here is that a small change in the first step results in the solution being on an entirely different trajectory. This sort of problem is known as *ill-conditioned*, and in particular this is an issue where, for our ODE

$$ \frac{\mathrm{d}y}{\mathrm{d}t} =f(t,y) $$

the partial derivative

$$\frac{\partial f(t,y)}{\partial y} > 0 $$

Ill-conditioned problems (as opposed to *well-conditioned*) are particularly unforgiving on the Euler Method and are good candidates for a higher-order method such as Runge-Kutta.


## Summary

That's all for new content! I'll be posting a practice test very soon and wish you a great holiday!