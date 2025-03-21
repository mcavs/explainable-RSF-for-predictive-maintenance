source("install_packages.R")
source("import_datasets.R")
source("task.R")
source("data_split.R")
source("modeling.R")
source("performance.R")
source("survlime_explain.R")


surv_task <- make_task()

split_data <- data_split(task = surv_task)

models <- train_models(task = surv_task, split = split_data)


lime_results <- survlime_explain(surv_task, split_data, models)
plot(lime_results$cox_lime, type = "local_importance")
plot(lime_results$rsf_lime, type = "local_importance")
print(lime_results)


shap_results <- survshap_explain(surv_task, split_data, models)
plot(shap_results$cox_shap)
plot(shap_results$rsf_shap)
print(shap_results)
