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


# PDP 

rsf_vars <- c("sensor_12", "sensor_15", "sensor_4", 
              "sensor_21", "sensor_14", "sensor_3", "sensor_7")

cox_vars <- c("sensor_14", "sensor_4", "sensor_8", 
              "sensor_13", "sensor_15", "sensor_7", "sensor_9")

rsf_profile_selected <- model_profile(global_results$rsf_explainer, variables = rsf_vars)
cox_profile_selected <- model_profile(global_results$cox_explainer, variables = cox_vars)

plot(rsf_profile_selected) +
  xlim(c(125, 250))
plot(cox_profile_selected) +
  xlim(c(125, 250))


# 
rsf_vimp <- plot(global_results$rsf_parts) +
  xlim(c(125, 250)) +
  theme(legend.title = element_blank(),
        plot.subtitle = element_blank(),
        plot.tag = element_blank(),
        plot.title = element_blank(),
        legend.position = "bottom") 

cox_vimp <- plot(global_results$cox_parts) +
  xlim(c(125, 250)) +
  theme(legend.title = element_blank(),
        plot.subtitle = element_blank(),
        plot.tag = element_blank(),
        plot.title = element_blank(),
        legend.position = "bottom") 

plot_grid(rsf_vimp, cox_vimp, labels = c("A", "B"))



perf_results <- measure_performance(models, surv_task, split_data)
perf_results$c_index
perf_results$brier
perf_results$auc


