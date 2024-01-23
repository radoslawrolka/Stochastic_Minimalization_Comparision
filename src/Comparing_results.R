library("smoof")
PRS = function(func,dim,random_trials)
{
  f = func(dim)
  result = Inf
  RandomPoints = replicate(random_trials,runif(dim,getLowerBoxConstraints(f),getUpperBoxConstraints(f)))
  for(i in 1:random_trials)
  {
    result=min(result,f(RandomPoints[,i]))
  }
  return (result)
}
MS_Minimalize <- function(func, dim, points_quantity) {
  f <- func(dim)
  values <- c(1:points_quantity)
  counter <- c(1:points_quantity) 
  
  MS <- replicate(n = points_quantity, optim(runif(dim, 
                                                   getLowerBoxConstraints(f), 
                                                   getUpperBoxConstraints(f)), 
                                             f, 
                                             method = "L-BFGS-B",
                                             lower = getLowerBoxConstraints(f), 
                                             upper = getUpperBoxConstraints(f))
  )
  for (i in 1:points_quantity) {
    values[i]  = MS[[2, i]]
    counter[i] = MS[[3, i]][2] 
  }
  return (list(min(values), mean(counter)))
}





