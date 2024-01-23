# Comparison of the Stochastic Minimization Algorithms
The comparisons were conducted for both methods in cases where the number of dimensions was:
- dim = 2
- dim = 10
- dim = 20
  
For each case, the method was executed 50 times. Due to the multiple runs of Multi-Start (MS), which involve gradient calculations, the cost of execution will be higher than that of Pure Random Search (PRS). To maintain a balanced budget, we will use the average cost of MS for all starts and proportionally increase the cost of PRS.

## Chosen Functions
### Alpine01 Function
<img src="https://github.com/radoslawrolka/stata/blob/master/documentation/img/Alpine01.png">

### Ackley's Function
<img src="https://github.com/radoslawrolka/stata/blob/master/documentation/img/Ackley.png">

## Chosen Stochastic Minimization Algorithms
### Pure-Random-Search
Pure Random Search, as the name suggests, is a straightforward stochastic optimization method that explores the solution space by randomly sampling points. In PRS, solutions are generated randomly, and the objective function is evaluated at each sampled point. The algorithm returns the minimum of all calculated values.

<img src="https://github.com/radoslawrolka/stata/blob/master/documentation/img/dim2_PRS_Ackley.png">

### Multi-Start
Multi-Start is an optimization technique that involves running a local optimization algorithm from multiple starting points. Instead of relying on a single initial guess, Multi-Start generates several starting points randomly or systematically and performs optimization from each of these points. The algorithm then compares the results from all runs and selects the best solution found.

<img src="https://github.com/radoslawrolka/stata/blob/master/documentation/img/dim10_MS_Alpine01_his.png">
