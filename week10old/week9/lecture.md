
## Where are we?

<table style="font-size: 0.7em;">
<tr>
<th></th>
<th>Week Begin</th>
<th>Topic</th>
<th>Scheduled</th>
<th>Assessment</th>
</tr>
<tr>
<td></td>
<td>6: 30th Nov</td>
<td>Differential equations I</td>
<td>Live online Thursday</td>
<td>Assessment 2 released (Mon 4pm)</td>
</tr>
<tr>
<td></td>
<td>7: 7th Dec</td>
<td>Differential equations II</td>
<td>live online Tuesday</td>
<td></td>
</tr>
<tr style="background: rgba(146,190,50,0.3)">
<td></td>
<td>8: 14th Dec</td>
<td>Differential equations III</td>
<td>Live online Thursday</td>
<td>Assessment 2 Due (Mon 4pm)</td>
</tr>
<tr>
<td colspan="5" style="text-align: center; background-color: #CCC;">Christmas vacation</td>
</tr>
<tr>
<td></td>
<td>9: 11th Jan</td>
<td>Revision</td>
<td>Live online Thursday</td>
<td></td>
</tr>
<tr>
<td></td>
<td>10: 18th Jan</td>
<td>Assessment</td>
<td></td>
<td>Assessment 3 (24 hours from Mon 4pm)</td>
</tr>
<tr>
<td colspan="5" style="text-align: center; background-color: #CCC;">Semester 2...</td>
</tr>
</table>

[View full timetable](https://ncl.instructure.com/courses/32310/pages/timetable)

---

## This week

We look at a number of considerations around accuracy and stability of numerical methods, primarily focussing on the Euler Method.

---

### Ill-conditioned ODEs

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


---

## Summary

This is the last new content for the module. Later in the week I'll publish a mock test to help you prepare for the January assessment.

