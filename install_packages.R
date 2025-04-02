install.packages(c(
  "readr", "dplyr", "ggplot2",
  "survival", "mlr3", "mlr3proba", "mlr3extralearners",
  "remotes", "survex", "randomForestSRC", "pracma", "cowplot"
))

library(remotes)
install_github("mlr-org/mlr3proba", force = TRUE)
install_github("mlr-org/mlr3extralearners", force = TRUE)

library(readr)
library(dplyr)
library(ggplot2)
library(survival)
library(mlr3)
library(mlr3proba)
library(mlr3extralearners)
library(survex)
library(randomForestSRC)
library(pracma)
library(cowplot)

install_learners(c("surv.ranger", "surv.coxph"))
