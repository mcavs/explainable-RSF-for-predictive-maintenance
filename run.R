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

##############################################################################################################
# RSF ve Cox Modelleri - Variable Importance
##############################################################################################################

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


##############################################################################################################
# RSF Modeli - Partial Dependence Plot (PDP) Grafikleri
##############################################################################################################

rsf_vars <- c("sensor_12")
rsf_profile_selected <- model_profile(global_results$rsf_explainer, variables = rsf_vars)
p12 <- plot(rsf_profile_selected, 
           title = NULL,
           subtitle = NULL) + 
  xlim(c(125, 250)) + 
  theme(legend.key.size = unit(1, "cm"))


rsf_vars <- c("sensor_14")
rsf_profile_selected <- model_profile(global_results$rsf_explainer, variables = rsf_vars)
p14 <- plot(rsf_profile_selected, 
           title = NULL,
           subtitle = NULL) + 
  xlim(c(125, 250)) + 
  theme(legend.key.size = unit(1, "cm"))


rsf_vars <- c("sensor_15")
rsf_profile_selected <- model_profile(global_results$rsf_explainer, variables = rsf_vars)
p15 <- plot(rsf_profile_selected, 
           title = NULL,
           subtitle = NULL) + 
  xlim(c(125, 250)) + 
  theme(legend.key.size = unit(1, "cm"))


rsf_vars <- c("sensor_21")
rsf_profile_selected <- model_profile(global_results$rsf_explainer, variables = rsf_vars)
p21 <- plot(rsf_profile_selected, 
           title = NULL,
           subtitle = NULL) + 
  xlim(c(125, 250)) + 
  theme(legend.key.size = unit(1, "cm"))


rsf_vars <- c("sensor_3")
rsf_profile_selected <- model_profile(global_results$rsf_explainer, variables = rsf_vars)
p3 <- plot(rsf_profile_selected, 
           title = NULL,
           subtitle = NULL) + 
  xlim(c(125, 250)) + 
  theme(legend.key.size = unit(1, "cm"))


rsf_vars <- c("sensor_4")
rsf_profile_selected <- model_profile(global_results$rsf_explainer, variables = rsf_vars)
p4 <- plot(rsf_profile_selected, 
           title = NULL,
           subtitle = NULL) + 
  xlim(c(125, 250)) + 
  theme(legend.key.size = unit(1, "cm"))


rsf_vars <- c("sensor_7")
rsf_profile_selected <- model_profile(global_results$rsf_explainer, variables = rsf_vars)
p7 <- plot(rsf_profile_selected, 
           title = NULL,
           subtitle = NULL) + 
  xlim(c(125, 250)) + 
  theme(legend.key.size = unit(1, "cm"))


plot_grid(p12, p14, p15, p21, p3, p4, p7, ncol = 2)


##############################################################################################################
# Cox Model - Partial Dependence Plot (PDP) Grafikleri
##############################################################################################################

cox_vars <- c("sensor_14")
cox_profile_selected <- model_profile(global_results$cox_explainer, variables = cox_vars)
p14 <- plot(cox_profile_selected, 
            title = NULL,
            subtitle = NULL) + 
  xlim(c(125, 250)) + 
  theme(legend.key.size = unit(1, "cm"))


cox_vars <- c("sensor_4")
cox_profile_selected <- model_profile(global_results$cox_explainer, variables = cox_vars)
p4 <- plot(cox_profile_selected, 
           title = NULL,
           subtitle = NULL) + 
  xlim(c(125, 250)) + 
  theme(legend.key.size = unit(1, "cm"))


cox_vars <- c("sensor_8")
cox_profile_selected <- model_profile(global_results$cox_explainer, variables = cox_vars)
p8 <- plot(cox_profile_selected, 
           title = NULL,
           subtitle = NULL) + 
  xlim(c(125, 250)) + 
  theme(legend.key.size = unit(1, "cm"))


cox_vars <- c("sensor_13")
cox_profile_selected <- model_profile(global_results$cox_explainer, variables = cox_vars)
p13 <- plot(cox_profile_selected, 
            title = NULL,
            subtitle = NULL) + 
  xlim(c(125, 250)) + 
  theme(legend.key.size = unit(1, "cm"))


cox_vars <- c("sensor_15")
cox_profile_selected <- model_profile(global_results$cox_explainer, variables = cox_vars)
p15 <- plot(cox_profile_selected, 
            title = NULL,
            subtitle = NULL) + 
  xlim(c(125, 250)) + 
  theme(legend.key.size = unit(1, "cm"))


cox_vars <- c("sensor_7")
cox_profile_selected <- model_profile(global_results$cox_explainer, variables = cox_vars)
p7 <- plot(cox_profile_selected, 
           title = NULL,
           subtitle = NULL) + 
  xlim(c(125, 250)) + 
  theme(legend.key.size = unit(1, "cm"))


cox_vars <- c("sensor_9")
cox_profile_selected <- model_profile(global_results$cox_explainer, variables = cox_vars)
p9 <- plot(cox_profile_selected, 
           title = NULL,
           subtitle = NULL) + 
  xlim(c(125, 250)) + 
  theme(legend.key.size = unit(1, "cm"))

plot_grid(p14, p4, p8, p13, p15, p7, p9, ncol = 2)


##############################################################################################################
# RSF ve Cox Modelleri - Performans Ölçümleri (C-index, Brier Score, AUC) 
##############################################################################################################

perf_results <- measure_performance(models, surv_task, split_data)
perf_results$c_index
perf_results$brier
perf_results$auc


