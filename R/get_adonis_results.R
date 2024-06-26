#' Gets the degress of freedom, p values and F values from the  Permanova computations. 
#'
#' @param x the adonis object to get the results from 
#'
#' @return a data table that has the p values, f values and the degrees of freedom
#' @export
#'
#' @examples 
get_adonis_results = function(x){
  
  #take the F value, p_value and df 
  p_value = signif(x[["Pr(>F)"]][1], 2)
  F_value = signif(x[["F"]][1], 3)
  df_value = as.character(paste0(x[["Df"]][1], ":", x[["Df"]][2]))
  
  # make a results table
  results = data.table(pair = c("all_regimes"),
                       p_value = p_value,
                       F_value = (F_value),
                       df_value = df_value)
  
  return(results)
}