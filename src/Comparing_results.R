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

compare_MS_to_PRS = function(dim,func,numberOfRuns,NumberOfPoints)
{
  MS_resultsCounter = replicate(numberOfRuns,MS_Minimalize(func,dim,NumberOfPoints))
  
  MS_Counter = mean(as.numeric(MS_resultsCounter[2,]))
  
  MS_results = as.numeric(MS_resultsCounter[1,])

  PRS_results = replicate(numberOfRuns,PRS(func,dim,NumberOfPoints*MS_Counter))
  
  t.test(MS_results,PRS_results,conf.level=0.95)
  
  
  
  
  hist_plot = hist(MS_results, main = "Histogram dla algorytmu MS", xlab = "Zakresy minimów", ylab = "Ilość minimów")
  hist_filename = paste0("dim",dim,"_MS_",sub("^make(.*)Function$","\\1", as.character(substitute(func))),"_his.png")
  png(hist_filename)
  plot(hist_plot)
  dev.off()
  
  
  
  hist_plot = hist(PRS_results, main = "Histogram dla algorytmu PRS", xlab = "Zakresy minimów", ylab = "Ilość minimów")
  hist_filename = paste0("dim",dim,"_PRS_",sub("^make(.*)Function$","\\1", as.character(substitute(func))),"_his.png")
  png(hist_filename)
  plot(hist_plot)
  dev.off()
  
  
  box_plot = boxplot(MS_results, main = "Wykres pudełkowy dla algorytmu MS", ylab = "Zakres minimów")
  box_filename = paste0("dim",dim,"_MS_",sub("^make(.*)Function$","\\1", as.character(substitute(func))),".png")
  png(box_filename)
  plot(box_plot)
  dev.off()
  
  box_plot = boxplot(PRS_results, main = "Wykres pudełkowy dla algorytmu PRS", ylab = "Zakres minimów")
  box_filename = paste0("dim",dim,"_PRS_",sub("^make(.*)Function$","\\1", as.character(substitute(func))),".png")
  png(box_filename)
  plot(box_plot)
  dev.off()
}

compare_MS_to_PRS(2,makeAlpine01Function,10,10)
#compare_MS_to_PRS(10,makeAlpine01Function,50,100)
#compare_MS_to_PRS(20,makeAlpine01Function,50,100)

#compare_MS_to_PRS(2,makeAckleyFunction,50,100)
#compare_MS_to_PRS(10,makeAckleyFunction,50,100)
#compare_MS_to_PRS(20,makeAckleyFunction,50,100)


