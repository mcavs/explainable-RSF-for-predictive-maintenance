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

global_results <- global_explain(surv_task, models)

plot(global_results$cox_parts) + ggtitle("Variable Importance - Cox Model")
plot(global_results$rsf_parts) + ggtitle("Variable Importance - RSF Model")

print(global_results)

plot(global_results$cox_profile)
plot(global_results$rsf_profile)
