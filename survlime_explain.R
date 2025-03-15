survlime_explain <- function(task, split, models) {
  library(survex)
  
  cox_explainer <- explain(models$cox_model, 
                           data = as.data.frame(task$data()), 
                           y = task$truth(), 
                           predict_function = predict)
  
  rsf_explainer <- explain(models$rsf_model, 
                           data = as.data.frame(task$data()), 
                           y = task$truth(), 
                           predict_function = predict)
  
  observation <- as.data.frame(task$data())[5, , drop = FALSE]
  
  cox_lime <- predict_parts(cox_explainer, observation, type = "survlime")
  rsf_lime <- predict_parts(rsf_explainer, observation, type = "survlime")
  
  plot(cox_lime, type = "local_importance")
  plot(rsf_lime, type = "local_importance")
  
  return(list(
    cox_lime = cox_lime,
    rsf_lime = rsf_lime
  ))
}
