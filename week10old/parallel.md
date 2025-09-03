# Parallel code

<div class="alert alert-warning">
	<p>I strongly recommend using your own device for this handout.</p>
	<p>If you are using AVD then you'll need to open Anaconda and then Spyder, or you'll find that <code>joblib</code> is not available to you. You may see warnings if you try to use too many jobs/cores though and would recommend <code>n_jobs=2</code>  in the below code at most.</p>
</div>


## The idea 

The idea is that, rather than using a single "core" on our device, we split a Python problem up to run many tasks in parallel, either using multiple connected devices - a supercomputer (as is typically done in scientific research) - or using multiple cores on one device (as we'll do in this handout).

<div style="float: left; width: 45%; margin-left: 5%" markdown=true>
**Serial programming:**

![Serial programming](/static/images/week10/serial.png){width=75%}
</div>
<div style="float: left; width: 45%; margin-left: 5%" markdown=true>

**Parallel programming:**

![Parallel programming](/static/images/week10/parallel.png){width=100%}
</div>

<br style="clear: both;">

### What is a core? {: .interlude}

A core is the basic computation unit of a CPU (Central Processing Unit), and typically handles one task at a time. Back when I first had a laptop, dual-core was the big thing, because it let you do two whole things at a time! Then it was quad-core, which are now very common. Taking a quick look at the PC World website, roughly half of laptops are quad-core, a quarter dual-core and the others hexa- or octa-core. A High Performance Computing (HPC) system used for scientific research might be made up of individual devices (nodes) each made up of 10, 20, 30 cores or more.


### Some code

There are several methods (and Python modules) for running code in parallel. I have no chance of introducing you to all the methods, but two words that often come up are *OpenMP* and *MPI*:

* In *OpenMP* (Open Multi-Processing) code, each task has access to everything (data, variables etc), all of the time, so is suited to "shared memory" devices (think like one device, e.g. your laptop). 

* In *MPI* (Message Passing Interface) code, messages can be passed between individual tasks, even if not on the same hardware. This code runs on what are called "distributed memory" devices (think many computers chained together). Then, of course, the speed and efficiency with which messages are passed becomes incredibly important.

We're going to basically be doing the former here. Well, at least a simple taste of it anyway!


```python
from joblib import Parallel, delayed

n = 1000

def func(i):
	"""
	Silly function to sum values from 0 to i
	"""
    s = 0
    for j in range(i):
        s += j
    return s

Parallel(n_jobs=4)(delayed(func)(i) for i in range(n))
```

The `Parallel` "function" (which is actually a class not a function, but let's not get into that here...) does the magic. The `delayed` function captures the name and input arguments of the function `func` without actually executing `func(i)`, so that the work doesn't happen until the code is in parallel (hence "delayed").

Worth saying, there are many alternatives to `joblib`, but it's a relatively lightweight module in terms of how many new things we need to introduce in order to get it running.

## Exercise {: .exercise}

Use the module `time` to time the above code. and compare to calling the same function `n` times in a for loop. 

The time module/function goes like this:

```python
import time

t1 = time.time()
# do something
t2 = time.time()
```

You'll likely find that your parallel code was not quicker at all, and that's because there's overhead involved in the actual set up of the parallel "stuff". Try increasing `n` (slowly, as this is going to scale in time like $n^2$)


### Joblib options

You can set the `verbose` option to a non-zero value to see what's going on under the hood

```python
Parallel(n_jobs=4,verbose=10)(delayed(func)(i) for i in range(n))
```

When you do that you'll actually see some of the "overhead", as the `Parallel` function tests the water with how to split the work into batches:

```output
[Parallel(n_jobs=4)]: Using backend LokyBackend with 4 concurrent workers.
[Parallel(n_jobs=4)]: Batch computation too fast (0.0025s.) Setting batch_size=2.
[Parallel(n_jobs=4)]: Done   5 tasks      | elapsed:    0.0s
[Parallel(n_jobs=4)]: Batch computation too fast (0.0043s.) Setting batch_size=4.
[Parallel(n_jobs=4)]: Done  12 tasks      | elapsed:    0.0s
[Parallel(n_jobs=4)]: Done  28 tasks      | elapsed:    0.0s
[Parallel(n_jobs=4)]: Batch computation too fast (0.0043s.) Setting batch_size=8.
```



## Worked example

In the mock exam we created a function to return a "matrix of minors". Stripping out the function for the purposes of this example, the code was

```python
import scipy.linalg as sla
import numpy as np

A = np.array([[1,2,3],
			 [4,5,6],
			 [7,8,9]])

# Array to stor minors in
M = np.zeros(A.shape)

# Loop through i and j
for i in range(0,A.shape[0]):
    for j in range(0,A.shape[1]):
        # Remove row i
        A_deleted_row = np.delete(A,i,axis=0)
        # Remove column j
        A_deleted_column = np.delete(A_deleted_row,j,axis=1)
        # Put determinant in M
        M[i,j] = sla.det(A_deleted_column)
```

Let's suppose we want to do this for a very large matrix. Let's first create a very large random matrix. We could use the `numpy.random` function `randint`:

```python
np.random.randint(5, size=(10, 10))
```
```output
array([[3, 3, 1, 7, 8, 5, 4, 1, 1, 0],
       [5, 4, 3, 4, 5, 7, 5, 2, 5, 1],
       [0, 6, 0, 4, 1, 0, 7, 9, 8, 5],
       [3, 2, 2, 9, 1, 9, 4, 5, 8, 7],
       [4, 0, 8, 5, 5, 4, 9, 6, 9, 6],
       [2, 3, 3, 9, 6, 0, 5, 2, 5, 6],
       [2, 1, 3, 2, 2, 2, 1, 7, 3, 6],
       [7, 7, 4, 2, 3, 8, 0, 0, 7, 5],
       [2, 8, 2, 7, 9, 7, 1, 2, 1, 1],
       [2, 6, 1, 5, 3, 0, 5, 5, 4, 6]])
```

Let's ramp it up big enough that it takes a while. I'll just use $-1$, $0$ and $1$ in my matrix as I'm going to get extremely large values...


```python
import scipy.linalg as sla
import numpy as np
import time

n = 250
A = np.random.randint(-1,2, size=(n, n))

t1 = time.time()

# Array to stor minors in
M = np.zeros(A.shape)

# Loop through i and j
for i in range(0,A.shape[0]):
    for j in range(0,A.shape[1]):
        # Remove row i
        A_deleted_row = np.delete(A,i,axis=0)
        # Remove column j
        A_deleted_column = np.delete(A_deleted_row,j,axis=1)
        # Put determinant in M
        M[i,j] = sla.det(A_deleted_column)
t2 = time.time()
print(t2-t1)
```

Setting `n` to 250 takes around 25 seconds on my laptop. Bear in mind that's then $250 \times 250 = 62,500$ matrix elements. Again, this problem is $\mathcal{O}(n^2)$.

OK, so how could we parallelise? Well we could do so over the top for loop. Consider this:

```python
from joblib import Parallel, delayed
import scipy.linalg as sla
import numpy as np
import time

n = 250

t1 = time.time()
A = np.random.randint(-1,2, size=(n, n))

# Array to stor minors in
M = np.zeros(A.shape)

def det_row(i):
    row = np.zeros(A.shape[1])
    for j in range(0,A.shape[1]):
        # Remove row i
        A_deleted_row = np.delete(A,i,axis=0)
        # Remove column j
        A_deleted_column = np.delete(A_deleted_row,j,axis=1)
        # Put determinant in M
        M[i,j] = sla.det(A_deleted_column)


# Loop through i and j
Parallel(n_jobs=4)(delayed(det_row)(i) for i in range(A.shape[0]))

t2 = time.time()
print(t2-t1)
```

That took 11 seconds, so was faster, but this is a problem...

```python
print(M)
```
```output
array([[0., 0., 0., ..., 0., 0., 0.],
       [0., 0., 0., ..., 0., 0., 0.],
       [0., 0., 0., ..., 0., 0., 0.],
       ...,
       [0., 0., 0., ..., 0., 0., 0.],
       [0., 0., 0., ..., 0., 0., 0.],
       [0., 0., 0., ..., 0., 0., 0.]])
```

Consulting the `joblib` [documentation](https://joblib.readthedocs.io/en/latest/parallel.html){target="_blank"} we find that the function does not support shared access to modify the same object (`M` in this case) by default, but we can use `require='sharedmem'` to do this:


```python
from joblib import Parallel, delayed
import scipy.linalg as sla
import numpy as np
import time

n = 250
A = np.random.randint(-1,2, size=(n, n))

# Array to stor minors in
M = np.zeros(A.shape)

def det_row(i):
    row = np.zeros(A.shape[1])
    for j in range(0,A.shape[1]):
        # Remove row i
        A_deleted_row = np.delete(A,i,axis=0)
        # Remove column j
        A_deleted_column = np.delete(A_deleted_row,j,axis=1)
        # Put determinant in M
        M[i,j] = sla.det(A_deleted_column)


t1 = time.time()

# Loop through i and j
Parallel(n_jobs=4, require='sharedmem')(delayed(det_row)(i) for i in range(A.shape[0]))

t2 = time.time()
print(t2-t1)
```

This time our `M` has values, but the code took 41 seconds and my laptop sounds like it's about to take off!

So what's the problem? Well, reading the above docs again, it says: "Keep in mind that relying a on the shared-memory semantics is probably suboptimal from a performance point of view as concurrent access to a shared Python object will suffer from lock contention". In plain english, whilst one process is modifying `M`, it "locks" it, such that the other one has to wait its turn.

OK, back to the drawing board. So why don't we just get `det_row` to return the row `i`. Then if we say `M = Parallel...`, our M will be a list of lists (so we can just wrap in `np.array()` to get back a matrix)


```python
from joblib import Parallel, delayed
import scipy.linalg as sla
import numpy as np
import time

n = 250
A = np.random.randint(-1,2, size=(n, n))

def det_row(i):
    row = np.zeros(A.shape[1])
    for j in range(0,A.shape[1]):
        # Remove row i
        A_deleted_row = np.delete(A,i,axis=0)
        # Remove column j
        A_deleted_column = np.delete(A_deleted_row,j,axis=1)
        # Put determinant in M
        row[j] = sla.det(A_deleted_column)
    return row

t1 = time.time()
# Loop through i and j
M = Parallel(n_jobs=4)(delayed(det_row)(i) for i in range(A.shape[0]))
M = np.array(M)

t2 = time.time()
print(t2-t1)
```

It works! 12 seconds compared to 25 in serial and `M` is consistent with the serial version (you can run both to check).


## Find out more

This mini handout is just a flavour to give you a sense of the idea of parallel code. For more info you might like to check out

* [The joblib documentation](https://joblib.readthedocs.io/en/latest/parallel.html){target="_blank"} to find out a bit more about using `joblib`.
* [Another article on joblib](https://towardsdatascience.com/using-joblib-to-speed-up-your-python-pipelines-dd97440c653d){target="_blank"} which looks at one of its other features: the idea of *caching* your results so that time can be saved when the same function is called with the same input repeatedly.
* [Introduction to parallel computing](https://hpc.llnl.gov/training/tutorials/introduction-parallel-computing-tutorial){target="_blank"} a nice tutorial going into some motivation, technical details and maths-y examples by the Livermore Computing Center (one of the biggest scientific computing facilities in the US). Not Python-specific

Finally, a reminder, parallel code <u>will not</u> form part of your January assessment!

