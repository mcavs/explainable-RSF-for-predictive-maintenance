train_models <- function(task, split) {
  
  set.seed(123)
  
  # Cox Model ################################################
  cox_model <- lrn("surv.coxph", id = "coxph")
  cox_model$train(task, row_ids = split$train)
  
  # RSF Model ################################################
  rsf_model <- lrn("surv.rfsrc", id = "rsf")
  rsf_model$train(task, row_ids = split$train)
  
  models <- list(
    cox_model = cox_model,
    rsf_model = rsf_model
  )
  
  return(models)
}
