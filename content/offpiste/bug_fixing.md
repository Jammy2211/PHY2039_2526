##  Bug 1

This script is meant to extract the first column of a 2D numpy array A
and double its values.

However, it contains a bug and does not given the expected result.

In the lecture I will show how to use print() statements to debug and fix this code.

**Intended behaviour**
A is:
[[1 1 1]
 [2 2 2]
 [3 3 3]]

The first column is [1, 2, 3].
Doubling it gives A is:

[[2 1 1]
 [4 2 2]
 [6 3 3]]

```python
import numpy as np

A = np.array([[1,1,1],
              [2,2,2],
              [3,3,3]])

A[0, :] = 2 * A[0, :]

expected = np.array([[2,1,1],
                     [4,2,2],
                     [6,3,3]])

assert np.array_equal(A, expected), "Column extraction is incorrect!"
```

```runnable lang="python"
import numpy as np

A = np.array([[1,1,1],
              [2,2,2],
              [3,3,3]])

A[0, :] = 2 * A[0, :]

expected = np.array([[2,1,1],
                     [4,2,2],
                     [6,3,3]])

assert np.array_equal(A, expected), "Column extraction is incorrect!"
```