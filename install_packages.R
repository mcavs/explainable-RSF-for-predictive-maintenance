install.packages("readr")
install.packages("dplyr")
install.packages("ggplot2")

install.packages("survival")  
install.packages("mlr3")      
install.packages("mlr3proba") 
install.packages("mlr3extralearners") 

install.packages("remotes")
library(remotes)
remotes::install_github("mlr-org/mlr3proba", force = TRUE)
remotes::install_github("mlr-org/mlr3extralearners", force = TRUE)

library(readr)
library(dplyr)
library(ggplot2)
library(survival)
library(mlr3)
library(mlr3proba)
library(mlr3extralearners)

install_learners(c(
  "surv.ranger",  
  "surv.coxph"  
))
install.packages("survex")
library(survex)
