## Today's plan

* Announcements

. . .

* Recap on this week's content

. . .

* Look back at the key parts of the course

. . .


* Assessment tips

--- 

## Announcements

* Marks and feedback for assignment 2
* Mock test

---


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


--- 

## "Mince Pyes Team": 

<s>(Future MSP Christmas Quiz winners)</s>

<div style="float:left; width: 140px; width: 130px; margin: 10px; margin-bottom: 30px;"> 
<b>Chris</b>
</div>
![Chris](/static/images/staff/chris.jpg){style="float: left; width: 140px; margin: 10px;"}


<div style="clear: both; float:left; width: 140px; width: 130px; margin: 10px"> 
<b>Laura</b>
</div>
![Laura](/static/images/staff/laura.png){style="float: left; width: 140px; margin: 10px;"}


<div style="float:left; width: 140px; width: 130px; margin: 10px"> 
<b>Ryan</b>
</div>
![Ryan](/static/images/staff/ryan.jpg){style="float: left; width: 140px; margin: 10px;"}

<br style="clear: both;">

---

## This week


---

### Truncation error

We'll be looking at how the *truncation error* depends on the Euler Method step size $h$.


![Plot of the local truncation error against stepsize h](/static/images/week8/lte.png){width=80%}


---

### Stability

The Euler Method is unstable beyond a critical value of $h$.

![Plot of the Euler Solution with h = 0.95, 1.0, 1.05](/static/images/week8/critical.png){width=80%}

---

## Directional fields

We looked at how vector plots can help us to visualise solutions

![Directional field plot for dy/dt = -y/2 with solutions y(0)=5 and y(0)=-5](/static/images/week8/directional2.png){width=90%}

---

### Ill-conditioned problems

The directional fields will help us to see how some problems are particularly unforgiving when solved with the Euler Method

![](/static/images/week8/illconditioned.png){width=90%}

---


## A nostalgic look back

---

### Python basics, plotting, control flow, functions

In weeks 1 and 3 we laid the groundwork for the main topics of this half of the module.

---

### Curve fitting

![Cubic fit](/static/images/week2/fit_cubic.png){width=70%}

---

We looked at functions:

* NumPy's `polyval`
* SciPy's `curve_fit`

And methods for:

* Calculating residuals
* Using `polyfit` to fit functions other than polynomials, e.g. $f(x) = a\exp(bx)$.

---

### Root finding

![Animation of the bisection method](/static/images/week2/bisection_animation.gif){width=65%}

---

We looked at functions:

* NumPy's `roots`
* SciPy's `fsolve`

And methods for:

* Calculating residuals
* Using `polyfit` to fit functions other than polynomials, e.g. $f(x) = a\exp(bx)$.


---

### Numerical differentiation and integration

![](/static/images/week3/finite_forwarddiff.png){width=60%}

---

We looked at functions for differentiation and integration:

* NumPy's `gradient`
* NumPy's `trapz`
* SciPy's `quad`


Quadrature methods for integration and finite difference methods for differentiation.

---

### Numerical solutions to ODEs

![](/static/images/week6/lotka1.png){width=80%}

---

We looked at 

* SciPy's `odeint`.
* The Euler Method
* Runge-Kutta Methods


---

## Assessment tips

---

## Marking

Read carefully the questions instructions.

**"Write a function called diff that takes in two values as input arguments and returns the absolute difference."**

. . .

How would you mark this?

--- 

```runnable  lang="python"
# Student code
a = 8
b = 4
diff = b - a

# Test
diff(4,8)
```

--- 

```runnable  lang="python"
# Student code
def diff(a,b):
    print("The absolute difference is {}".format(abs(b-a)))

# Test
diff(4,8)
```

---


```runnable  lang="python"
# Student code
def diff(a,b):
    return abs(b-a)

diff(a,b)

# Test
diff(4,8)
```

---


```runnable  lang="python"
# Student code
def diff(a,b):
    return abs(b-a)

diff = diff(2,3)

# Test
diff(4,8)
```

---

The marking test is going to look something like 

```python
diff(8,4)==4 and diff(4,8)==4
```

. . .

This is sufficient:

```runnable  lang="python"
def diff(a,b):
    return abs(b-a)
```


---

## How to prepare for the January assessment

* make sure you understand the handouts
* be prepared to tackle something new with an open mind, or to be able to use an unseen function (know how to find help)
* try the Test Yourself quizes (uptake between 20-80%)
* try the mock/practice test (next week)

---

## Merry Christmas! {: data-background="/static/images/week8/xmas-frame.jpg"}

Have a fantastic break and I look forward to seeing you in week 9
