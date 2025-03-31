#################################################################
# Global Açıklama (Variable Importance - Partial Dependence)
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
  
  cox_profile <- model_profile(cox_explainer)
  rsf_profile <- model_profile(rsf_explainer)
  
  return(list(
    cox_parts   = cox_parts,
    rsf_parts   = rsf_parts,
    cox_profile = cox_profile,
    rsf_profile = rsf_profile
  ))
}
