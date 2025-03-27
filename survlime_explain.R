#################################################################
# SURVLIME 
#################################################################

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


#################################################################
# SURVSHAP
#################################################################

survshap_explain <- function(task, split, models) {
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

  cox_shap <- predict_parts(cox_explainer, observation, type = "survshap")
  rsf_shap <- predict_parts(rsf_explainer, observation, type = "survshap")

  plot(cox_shap)
  plot(rsf_shap)

  return(list(
    cox_shap = cox_shap,
    rsf_shap = rsf_shap
  ))
}


#################################################################
# Global Açıklama
#################################################################

global_explain <- function(task, models) {
  library(survex)
  
  cox_explainer <- explain(models$cox_model,
                           data = as.data.frame(task$data()),
                           y = task$truth(),
                           predict_function = predict)
  
  rsf_explainer <- explain(models$rsf_model,
                           data = as.data.frame(task$data()),
                           y = task$truth(),
                           predict_function = predict)
  
  cox_parts <- model_parts(cox_explainer)
  rsf_parts <- model_parts(rsf_explainer)
  
  plot(cox_parts)
  plot(rsf_parts)
  
  return(list(
    cox = cox_parts,
    rsf = rsf_parts
  ))
}

