####  Universität Duisburg-Essen ############
###### Machine Learning in Finance ###########################
##### Chair of Finance ###############################################
##### Summer term 2025 #########################################################
##### Student: Ayda Beiram Zadeh ################
##### Student: Thi Hong Cam Nguyen ################


####Content#######
### DataPreparation & Explore: From Row 18#####
### Logistic Regression: From Row 331####
### Ridge: From Row 486 ####
### Decision Tree and Forest: From Row 644#####
### XGBoost: From Row 871 #####


##### I. Data Preparartion & Exploratory  ###########################################




# Install only once if not already installed
install.packages(c("tidyverse", "tidymodels", "skimr", "janitor"))
install.packages("GGally", dependencies = TRUE)
install.packages("ggplot2")
# Load libraries
library(tidyverse)
library(tidymodels)
library(skimr)
library(janitor)
library(ggplot2)
library(GGally)
library(dplyr)
library(vip)

library(recipes)
library(themis)
library(vip)
library(corrplot)
################### 1. LOADING THE DATA AND GETTING AN OVERVIEW

# Load train data
setwd("~/Documents/uni_UDE/Machinelearning_in_Finance/coding-challenge-machine-learning-in-finance-msm")
train <- read_csv("train.csv")%>%
  clean_names() %>% # Makes column names easier to work with, classify variables into numeric (dbl) and character (chr)
  mutate(has_cr_card = as.factor(has_cr_card),
         is_active_member= as.factor(is_active_member),
         exited = as.factor(exited),customer_id = as.character(customer_id),
         geography = as.factor(geography),
         gender = as.factor(gender)
  )  # ✅ Convert target to factor for classification

# Preview structure
glimpse(train)
str(train)




skim(train)
#->There are 165034 observations with  23221 unique customer_id and there is NO MISSING VALUE



# We use skim() instead of summary() because:
# - skim() gives more detailed info: missing values, types, histograms
# - skim() works well with both numeric and categorical data
# - summary() is simpler and shows only basic stats (min, mean, max, etc.)
# skim() is more helpful for machine learning workflows


# This transformed Data set will be used for building all models in this term paper.


####################### 2. Exploratory Data Analysis (EDA) 
# A. Missing values
# B. Understand class balance (exited)
# C. Explore categorical and numeric features

# Check class distribution of the target variable
# => This tells us how many customers exited vs stayed (important for classification balance)
# prop : how many % of customers exited vs stayed

### Quick summary stats
#Get the summary statistics for the categorical data
train %>%
  keep(is.factor) %>%
  summary()
#-> There is no balance in exited (0: 130 113 observations, 1:34921 observations)
# Get summary statistics for the salary and balance feature. 
summary(select(train,tenure, balance,credit_score, estimated_salary ))


library(ggplot2)



# Calculate mean values of numeric features by churn status
# => Helps us understand if churned vs non-churned customers differ on average
train %>%
  group_by(exited) %>%
  summarise(across(where(is.numeric), \(x) mean(x)))

# After grouping by churn status (exited), we see:
# - Churned customers are older and have higher account balances on average
# - These differences suggest that age and balance might help predict churn

#-----

# Explore how churn (exited) varies by Geography
# => Useful to see if customer location affects churn
# Churn count and percentage by geography

train %>%
  count(geography, exited) %>%
  group_by(geography) %>%
  mutate(percent = round(n / sum(n) * 100, 1))

# Germany has a much higher churn rate (~38%) compared to France (~17%) and Spain (~17%)
# => Geography is likely an important predictor

#------

# Explore how churn (exited) varies by Gender
# => Helps identify any imbalance or trends by gender

train %>%
  count(gender, exited) %>%
  group_by(gender) %>%
  mutate(percent = round(n / sum(n) * 100, 1))

# Female customers churn more (~28%) than male customers (~16%)
# => Gender may also be useful in prediction

####################### 3. EXPLORATORY VISUALIZATIONS 
#Bar Chart of Exited Customer according to Gender and Geography
ggplot(train, aes(x = exited, y = balance)) +
  geom_point()

ggplot(train, aes(x = exited, y = gender)) +
  geom_point()

ggplot(train, aes(x = gender, fill = exited)) +
  geom_bar(position = "dodge") +
  facet_wrap(~ geography) +
  labs(title = "Exited Observations by Gender and Geography",
       x = "Gender",
       y = "Number of observations",
       fill = "Exited")
# Histogram: Age distribution
ggplot(train, aes(x = age)) +
  geom_histogram(fill = "lightblue", color = "black", bins = 30) +
  labs(title = "Distribution of Customer Age", x = "Age", y = "Count") +
  theme_minimal()
# 💬 Interpretation:
# - Most customers are between 30 and 40 years old.
# - The age distribution is slightly right-skewed (more younger than older customers).
# - There are fewer customers above 60 — older customers are underrepresented.
# Distribution of age
ggplot(train, aes(x = age, fill = exited)) +
  geom_density(alpha = 0.5) +
  labs(
    title = "Age Density of Customers by Churn Status",
    x = "Age",
    y = "Density",
    fill = "Exited"
  ) +
  scale_fill_manual(values = c("0" = "blue", "1" = "red")) +
  theme_minimal()
#Most non-churned customers are clustered between 25 and 40 years old.
#Most churned customers are concentrated between 40 and 55 years old.

#Correlation Matrix
cor_mat <-
  train %>% 
  select(where(is.numeric)) %>% 
  cor()

corrplot(
  title = "\n\nCorrelation Matrix",
  cor_mat,
  method = "number",
  order = "alphabet",
  type = "lower",
  diag = FALSE,
  number.cex = 0.8,
  tl.cex = 0.8,
  bg="darkgrey",
  tl.col = "darkgreen"
)
#Correlation Matrix
cor_mat <-
  train %>% 
  select(where(is.numeric)) %>% 
  cor()

corrplot(
  title = "Correlation Matrix",
  cor_mat,
  method = "color",
  order = "alphabet",
  type = "lower",
  diag = FALSE,
  number.cex = 0.8,
  tl.cex = 0.8,
  bg="white",
  tl.col = "darkgreen"
)
# Most variables are very weakly or not correlated.

#The only semi-notable relationship is between num_of_products and balance (r = -0.36).
#This suggests low multicollinearity, which is generally good for regression models.
train %>%
  select(exited) %>%
  count(exited) %>% mutate(percent = paste0(round(n / sum(n) * 100), "%"), 2) %>%
  ggplot(aes(
    x = factor(exited),
    y = n,
    label = percent,
    fill = exited
  )) +
  geom_col(show.legend = FALSE) +
  geom_text(vjust = -0.2, color = "#7C4EA8") +
  scale_fill_manual(values = c("#EF1A25", "#0099D5")) +
  scale_y_continuous(labels = label_number())+
  labs(
    title = "Churn distribution",
    caption = "Data Source: Kaggle | Coding Challenge Machine Learning in Finance",
    x = NULL,
    y = NULL,
    fill = NULL
  )

# : Balance vs Churn
ggplot(train, aes(x = as.factor(exited), y = balance)) +
  geom_boxplot(fill = "lightblue") +
  labs(title = "Balance by Churn Status", x = "Exited (Churn)", y = "Balance") +
  theme_minimal()

ggplot(train, aes(x = balance, fill = exited)) +
  geom_density(alpha = 0.5) +
  labs(
    title = "Balance Density of Customers by Churn Status",
    x = "Balance",
    y = "Density",
    fill = "Exited"
  ) +
  scale_fill_manual(values = c("0" = "blue", "1" = "red")) +
  theme_minimal()


# 💬 Interpretation:
# - On average, customers who exited (1) have a higher account balance than those who stayed (0).
# - However, the distribution has many customers with 0 balance in both groups.
# - Some high outliers exist — possibly wealthy clients.
# - Balance may be a useful feature to predict churn.

library(dplyr)
library(ggplot2)

train %>%
  count(num_of_products, exited) %>%
  ggplot(aes(x = factor(num_of_products), y = n, fill = factor(exited))) +
  geom_col(position = "dodge") +
  scale_fill_manual(values = c("#EF1A25", "#0099D5"), 
                    labels = c("Stayed", "Exited")) +
  scale_y_continuous(labels = scales::label_comma()) +
  labs(
    title = "Churn by Number of Products",
    x = "Number of Products",
    y = "Number of Customers",
    fill = "Customer Status"
  ) +
  theme_minimal()
ggplot(train, aes(x = num_of_products)) +
  geom_histogram(fill = "lightblue", color = "black", bins = 5) +
  labs(title = "Distribution of Number of Product", x = "Number of Product", y = "Count") +
  theme_minimal()


####################### 4. PREPROCESSING RECIPE
# Recipe: Remove unnecessary columns, dummy categorical vars, normalize numerics


# Load tidymodels (again, in case you restarted R)
library(tidymodels)

# Create a preprocessing recipe
churn_rec <- recipe(exited ~ ., data = train
                  ) %>%
  # Remove non-informative or identifier columns (like id, customer_id, surname,..)
  step_rm(id, customer_id, surname) %>%
  
  # Convert categorical variables to dummy (one-hot) encoding (like gender, geography,..)
  step_dummy(all_nominal_predictors()) %>%
  
  # Remove columns with zero variance (if any)
  step_zv(all_predictors()) %>%
  
  
  # Normalize all numeric predictors (like age, balance,.. --> important for models like logistic regression, NN, etc.)
  step_normalize(all_numeric_predictors())

#######################  4. SPLITTING THE DATA TO TRAIN & TEST 

# Set seed for reproducibility
set.seed(123)

# Split 80% training, 20% testing
churn_split <- initial_split(train, prop = 0.8, strata = exited)
# strata = keeps the same proportion of customers who exited and stayed


# Create training and validation sets
churn_train <- training(churn_split)
churn_test  <- testing(churn_split)

# Check the proportions for the class between all 3 datasets.
round(prop.table(table(select(train, exited), exclude = NULL)), 4) * 100
round(prop.table(table(select(churn_train, exited), exclude = NULL)), 4) * 100
round(prop.table(table(select(churn_test, exited), exclude = NULL)), 4) * 100







#-------------------------------------------------------------------------------
####################### II.LOGISTIC REGRESSION MODEL########### 



# ----------------------------
# MODEL SPECIFICATION & WORKFLOW
# ----------------------------

library(tidyverse)    # Includes dplyr, ggplot2, readr, etc.
library(tidymodels)   # Includes parsnip, recipes, workflows, yardstick, etc.

# Define model
logistic_model <- logistic_reg() %>%
  set_engine("glm") %>%
  set_mode("classification")
summary(logistic_model)
# Create workflow: combine recipe and model
logistic_wf <- workflow() %>%
  add_model(logistic_model) %>%
  add_recipe(churn_rec)

# Fit model on training data
logistic_fit <- logistic_wf %>%
  fit(data = churn_train)
#Summary the model
glm_model <- extract_fit_engine(logistic_fit)
summary(glm_model)



library(car)
vif(glm_model) #Check the multicollinearity

# always greater or equal to 1. The vif of balance is 1.65 which indicates that the variance is 65% bigger than
#what you would expect if there was no correlation with other independent variables. If VIF is 1, it means that
# it is not correlated with any of other variables. VIF from 1 to 5 is still exist but it not cause for concern
#VIF over 5 is problematic and thus the variable should be remove from the model. There is no VIF here over 2, so
#it is okay
# ----------------------------
# PREDICT & EVALUATE MODEL PERFORMANCE
# ----------------------------

# ----------------------------
# EVALUATE MODEL PERFORMANCE
# ----------------------------

# Predict both probabilities and class labels on the test set
# .pred_1 is the probability of churn (exited = 1)
# .pred_class is the predicted class label (0 or 1)
logistic_preds <- predict(logistic_fit, churn_test, type = "prob") %>%
  bind_cols(predict(logistic_fit, churn_test), churn_test)
logistic_preds

logistic_preds <- predict(logistic_fit, churn_test, type = "prob") %>%
  bind_cols(churn_test %>% select(exited))
logistic_preds


test_predictions <- predict(logistic_fit, churn_test, type = "prob") %>%
  mutate(.pred_class = if_else(.pred_0 > 0.5, "1", "0") %>% as.factor()) %>%
  bind_cols(churn_test %>% select(exited))

# ROC AUC
roc_auc(logistic_preds, truth = exited, .pred_0)

#Creating confusion matrix

actual_churn <- churn_test$exited
predicted_churn <- logistic_preds$exited

outcomes<- table(predicted_churn,actual_churn)
prop.table(outcomes)
confusion <- conf_mat(outcomes)
confusion
actual_churn <- churn_test$exited
predicted_churn <- logistic_preds$exited



autoplot(confusion)
summary(confusion, event_level="second")
library(ggplot2)
library(dplyr)
library(yardstick)
library(tibble)

# Calculate AUC (Area Under ROC Curve)
# Measures how well the model distinguishes between churned and non-churned customers

logistic_preds <- predict(logistic_fit, churn_test, type = "prob") %>%
  bind_cols(churn_test %>% select(exited)) %>%
  mutate(.pred_class = if_else(.pred_1 > 0.5, "1", "0") %>% as.factor())
logistic_preds %>%
  roc_auc(truth = exited, .pred_0)
# AUC = 0.817
# this is a very good result. AUC should be between 0.5 and 1.0 for a useful model.

#predicted_data <- train %>% select(id) %>% mutate(Excited=) 
# Calculate Accuracy
# Measures overall % of correct class predictionslogistic_preds %>%
logistic_preds %>%
  accuracy(truth = exited, estimate = .pred_class)

logistic_preds %>%
  mutate(
    .pred_class = if_else(.pred_0 <= .pred_1, "1", "0") %>% as.factor()
  ) %>%
  accuracy(truth = exited, estimate = .pred_class)
# Accuracy = 83.3%# Accuracexitedy = 83.3%
# ✅ At first glance, this looks good — it means the model correctly predicts 83.3% of customers.
# ❗ However, this can be misleading in imbalanced datasets where most customers do not churn.


# Make a tibble manually
conf_df <- tibble(
  Truth = factor(actual_churn, levels = c(1, 0), labels = c("Churn", "Non_Churn")),
  Prediction = factor(predicted_churn, levels = c(1, 0), labels = c("Churn", "Non_Churn"))
)

# Plot the confusion matrix
conf_df %>%
  count(Truth, Prediction) %>%
  ggplot(aes(x = Truth, y = Prediction, fill = n)) +
  geom_tile() +
  geom_text(aes(label = n), color = "white", size = 6) +
  scale_fill_gradient(low = "#FFA07A", high = "#FF4500") +
  labs(title = "Confusion Matrix", x = "Actual", y = "Predicted") +
  theme_minimal()



# ----------------------------
# 9. Variable Importance
# ----------------------------
logistic_fit %>%
  extract_fit_parsnip() %>%
  tidy() %>%
  arrange(desc(abs(estimate)))


plot1<-logistic_fit %>%
  extract_fit_parsnip() %>%
  vip(
    num_features = 11,
    geom = "point",
    horizontal = TRUE,
    aesthetics = list(color = "black", size = 3)
  ) +
  labs(title = "Variable Importance Logistic ")

# ----------------------------
# 10. Conclusion
# ----------------------------
# - Accuracy: 83.3% (but misleading)
# - AUC: 0.817 (good)


# ✅ Recommendation: Use this as a simple baseline. Explore LASSO, tree-based models, or boosting next.
# ----------------------------
# MODEL CONCLUSION
# ----------------------------

# Logistic Regression Results:
# - Accuracy: 83.3%
# - AUC: 0.817

# 🔍 Interpretation:
# The model appears to perform well in terms of accuracy, correctly classifying over 83% of the test cases.


# ✅ Recommendation: Use this as a simple baseline. Explore Ridge tree-based models, or boosting next.



########## III. RIDGE #####################

# RIDGE 
# ----------------------------
# 1. Install and Load Packages
# ----------------------------
#install.packages("themis")  # Only once if not installed
library(tidymodels)
library(readr)
library(tidyverse)
library(skimr)
library(janitor)
library(ggplot2)
library(GGally)
library(dplyr)
library(themis)

# ----------------------------
# 2. Load Data and Prepare Target
# ----------------------------
data <- read_csv("train.csv") %>%
  mutate(Exited = as.factor(Exited))

# ----------------------------
# 3. Train/Test Split
# ----------------------------
set.seed(123)
data_split <- initial_split(data, prop = 0.8, strata = Exited)
train_data <- training(data_split)
test_data  <- testing(data_split)

# ----------------------------
# 4. Preprocessing Recipe
# ----------------------------
ridge_recipe <- recipe(Exited ~ ., data = train_data) %>%
  update_role(id, CustomerId, Surname, new_role = "ID") %>%
  step_novel(all_nominal_predictors()) %>%
  step_dummy(all_nominal_predictors()) %>%
  step_zv(all_predictors()) %>%
  step_normalize(all_numeric_predictors()) %>%
  step_smote(Exited)  # Oversampling minority class


prepped <- prep(ridge_recipe)
juice(prepped) %>% count(Exited)# To see data set after step smote
# ----------------------------
# 5. Define Ridge Model
# ----------------------------
ridge_spec <- logistic_reg(penalty = tune(), mixture = 0) %>%  # mixture = 0 = Ridge
  set_mode("classification") %>%
  set_engine("glmnet")

# ----------------------------
# 6. Workflow
# ----------------------------
ridge_wf <- workflow() %>%
  add_recipe(ridge_recipe) %>%
  add_model(ridge_spec)

# ----------------------------
# 7. Cross-Validation and Grid
# ----------------------------
set.seed(123)
cv_folds <- vfold_cv(train_data, v = 10)
ridge_grid <- grid_regular(penalty(range = c(-4, 0)), levels = 20)

# ----------------------------
# 8. Model Tuning
# ----------------------------
tune_results <- tune_grid(
  ridge_wf,
  resamples = cv_folds,
  grid = ridge_grid,
  metrics = metric_set(roc_auc)
)

# Best Penalty
show_best(tune_results, metric = "roc_auc", n = 5)

# ----------------------------
# 9. Performance Plot
# ----------------------------
autoplot(tune_results) +
  labs(
    title = "Ridge Regression Performance",
    subtitle = "ROC AUC vs. Penalty (λ)",
    x = "Penalty (λ)", y = "ROC AUC"
  )

# ----------------------------
# 10. Finalize and Fit Model
# ----------------------------
best_params <- select_best(tune_results, metric = "roc_auc")
final_ridge_wf <- finalize_workflow(ridge_wf, best_params)
final_ridge_fit <- fit(final_ridge_wf, data = train_data)

plot2<-final_ridge_fit %>%
  extract_fit_parsnip() %>%
  vip(
    num_features = 11,
    geom = "point",
    horizontal = TRUE,
    aesthetics = list(color = "black", size = 3)
  ) +
  labs(title = "Variable Importance Ridge  ")
# ----------------------------
# 11. Predict and Evaluate on Test Set
# ----------------------------
test_predictions <- predict(final_ridge_fit, test_data, type = "prob") %>%
  mutate(.pred_class = if_else(.pred_0 > 0.5, "0", "1") %>% as.factor()) %>%
  bind_cols(test_data %>% select(Exited))

# ROC AUC
roc_auc(test_predictions, truth = Exited, .pred_0)

# Confusion Matrix
conf_mat(test_predictions, truth = Exited, estimate = .pred_class)
confusion <- conf_mat(test_predictions, truth = Exited, estimate = .pred_class)
summary(confusion)
# Accuracy
accuracy(test_predictions, truth = Exited, estimate = .pred_class)

# Sensitivity (Recall for "Exited" = 1)
sens(test_predictions, truth = Exited, estimate = .pred_class)

# Specificity (Recall for "Stayed" = 0)
specificity(test_predictions, truth = Exited, estimate = .pred_class)



# ----------------------------
# 12. Final Interpretation Summary
# ----------------------------

# BEFORE SMOTE:
# - AUC:       0.818 → strong ranking performance
# - Accuracy:  82.9%
# - Sensitivity: 96.6% → excellent at identifying churners
# - Specificity: 31.8% → weak at identifying stayers

# AFTER SMOTE:
# - AUC:       0.818
# - Accuracy:  75.2%
# - Sensitivity: 75.7% → better balance
# - Specificity: 73.1% → significant improvement

# ✅ Recommendation:
# Use Ridge + SMOTE for a well-balanced model:
# - Great ranking (AUC)
# - Strong recall (sensitivity)
# - Much-improved specificity




#-------------------------------------------------------------------------------------------------


########## IV. Decision Tree & Random Forest #####################


# RANDOM FOREST
# ----------------------------
# 1. Load Libraries
# ----------------------------
library(tidyverse)
library(tidymodels)
library(skimr)
library(themis)
library(rpart)
library(rpart.plot)
library(ranger)
library(yardstick)
library(ggplot2)

# ----------------------------
# 2. Load Data & Inspect
# ----------------------------
data <- read_csv("train.csv") %>%
  mutate(Exited = as.factor(Exited))

glimpse(data)
skim(data)

# ----------------------------
# 3. Train-Test Split
# ----------------------------
set.seed(42)
data_split <- initial_split(data, prop = 0.8, strata = Exited)
train_data <- training(data_split)
test_data  <- testing(data_split)

# Optional: Sample to speed up tuning
set.seed(42)
train_sample <- train_data %>% sample_n(5000)

# ----------------------------
# 4. Preprocessing Recipe
# ----------------------------
rf_recipe <- recipe(Exited ~ ., data = train_data) %>%
  update_role(id, CustomerId, Surname, new_role = "ID") %>%
  step_novel(all_nominal_predictors()) %>%
  step_dummy(all_nominal_predictors()) %>%
  step_zv(all_predictors()) %>%
  step_smote(Exited)

# ----------------------------
# 5. Simple Decision Tree (Baseline & Interpretation)
# ----------------------------
tree_spec <- decision_tree(
  cost_complexity = tune(),
  tree_depth = tune(),
  min_n = tune()
) %>%
  set_engine("rpart") %>%
  set_mode("classification")

tree_wf <- workflow() %>%
  add_recipe(rf_recipe) %>%
  add_model(tree_spec)

tree_grid <- grid_regular(
  cost_complexity(range = c(-4, -1)),
  tree_depth(range = c(2, 8)),
  min_n(range = c(10, 30)),
  levels = 3
)

set.seed(42)
tree_tuned <- tune_grid(
  tree_wf,
  resamples = vfold_cv(train_sample, v = 3, strata = Exited),
  grid = tree_grid,
  metrics = metric_set(accuracy, roc_auc)
)
show_best(tree_tuned, metric = "roc_auc")
best_tree_params <- select_best(tree_tuned, metric = "roc_auc")
final_tree_wf <- finalize_workflow(tree_wf, best_tree_params)
final_tree_fit <- fit(final_tree_wf, data = train_data)

final_tree_fit %>%
  extract_fit_engine() %>%
  rpart.plot(roundint = FALSE, fallen.leaves = TRUE)

tree_pred <- predict(final_tree_fit, new_data = test_data, type = "prob") %>%
  bind_cols(test_data %>% select(Exited)) %>%
  mutate(pred_class = if_else(.pred_1 > 0.5, "1", "0") %>% factor(levels = c("0", "1")))

# Evaluate Tree
metrics(tree_pred, truth = Exited, estimate = pred_class)
recall(tree_pred, truth = Exited, estimate = pred_class)
precision(tree_pred, truth = Exited, estimate = pred_class)
conf_mat(tree_pred, truth = Exited, estimate = pred_class)
roc_auc(tree_pred, truth = Exited, .pred_1, event_level = "second")

plot3<-final_tree_fit %>%
  extract_fit_parsnip() %>%
  vip(
    num_features = 11,
    geom = "point",
    horizontal = TRUE,
    aesthetics = list(color = "black", size = 3)
  ) +
  labs(title = "Variable Importance Decision Tree  ")

# ----------------------------
# 6. Random Forest Specification & Tuning
# ----------------------------
rf_spec <- rand_forest(
  mtry = tune(),
  min_n = tune(),
  trees = 200
) %>%
  set_engine("ranger", importance = "impurity") %>%
  set_mode("classification")

rf_wf <- workflow() %>%
  add_recipe(rf_recipe) %>%
  add_model(rf_spec)

# CV and Grid
folds <- vfold_cv(train_data, v = 5, strata = Exited)

rf_grid <- grid_regular(
  mtry(range = c(3, 7)),
  min_n(range = c(10, 20)),
  levels = 3
)

set.seed(42)
rf_tuned <- tune_grid(
  rf_wf,
  resamples = vfold_cv(train_sample, v = 3, strata = Exited),
  grid = rf_grid,
  metrics = metric_set(accuracy, roc_auc)
)

best_params <- select_best(rf_tuned, metric = "roc_auc")
final_rf_wf <- finalize_workflow(rf_wf, best_params)
final_rf_fit <- fit(final_rf_wf, data = train_data)

# ----------------------------
# 7. Predictions at Threshold 0.5
# ----------------------------
rf_pred_05 <- predict(final_rf_fit, test_data, type = "prob") %>%
  bind_cols(test_data %>% select(Exited)) %>%
  mutate(pred_class = if_else(.pred_1 > 0.5, "1", "0") %>% factor(levels = c("0", "1")))

metrics(rf_pred_05, truth = Exited, estimate = pred_class)
recall(rf_pred_05, truth = Exited, estimate = pred_class)
precision(rf_pred_05, truth = Exited, estimate = pred_class)
conf_mat(rf_pred_05, truth = Exited, estimate = pred_class)

# ----------------------------
# 8. Predictions at Threshold 0.4
# ----------------------------
rf_pred_04 <- predict(final_rf_fit, test_data, type = "prob") %>%
  bind_cols(test_data %>% select(Exited)) %>%
  mutate(pred_class = if_else(.pred_1 > 0.4, "1", "0") %>% factor(levels = c("0", "1")))

metrics(rf_pred_04, truth = Exited, estimate = pred_class)
recall(rf_pred_04, truth = Exited, estimate = pred_class)
precision(rf_pred_04, truth = Exited, estimate = pred_class)
conf_mat(rf_pred_04, truth = Exited, estimate = pred_class)

# ----------------------------
# 9. ROC AUC & Curve
# ----------------------------
roc_auc(rf_pred_05, truth = Exited, .pred_1, event_level = "second")

roc_data <- rf_pred_05 %>%
  roc_curve(truth = Exited, .pred_1, event_level = "second")

autoplot(roc_data)

plot4<-final_rf_fit %>%
  extract_fit_parsnip() %>%
  vip(
    num_features = 11,
    geom = "point",
    horizontal = TRUE,
    aesthetics = list(color = "black", size = 3)
  ) +
  labs(title = "Variable Importance Random Forest  ")

# ----------------------------
# 10. Final Evaluation Summary
# ----------------------------

# Threshold 0.5:
# - Accuracy: 86.3%
# - ROC AUC: 0.886
# - TP: 4,061 | FN: 2,924 | FP: 1,599 | TN: 24,424

# Threshold 0.4:
# - TP: 4,607 | FN: 2,378 | FP: 2,442 | TN: 23,581
# - Recall ↑ | Precision slightly ↓
# - ROC AUC stays ~0.886

# ✅ Conclusion:
# - Random Forest is well-tuned and performs excellently (AUC ~0.89)
# - Threshold tuning helps balance recall vs precision
# - Suitable for churn prevention campaigns with high recall priority
# - Visual tree + variable importance help explain model

# ----------------------------
# 11. (Optional) Compare Tree vs Forest ROC Curves
# ----------------------------
model_comparison <- bind_rows(
  tree_pred %>% mutate(model = "Decision Tree"),
  rf_pred_05 %>% mutate(model = "Random Forest")
)

autoplot(
  model_comparison %>%
    group_by(model) %>%
    roc_curve(truth = Exited, .pred_1, event_level = "second"),
  color = "model"
)



#-------------------------------------------------------------------------------------------------


########## V. XGBoost #####################



# ============================================================
# XGBOOST MODEL: CUSTOMER CHURN PREDICTION + KAGGLE SUBMISSION
# ============================================================

# --- Load Required Packages ---
library(tidymodels)   # Unified ML framework
library(readr)        # For reading CSV files
library(vip)          # For feature importance visualization
library(dplyr)        # Data manipulation
library(themis)       # For SMOTE
library(ggplot2)      # For EDA plots

# ============================================================
# STEP 1: LOAD AND EXPLORE DATA
# ============================================================

data <- read_csv("train.csv")

# Basic shape
cat("Rows:", nrow(data), "\n")
cat("Columns:", ncol(data), "\n\n")

# Preview first few rows
print(head(data))

# Data types
cat("\nData types:\n")
str(data)

# Missing values per column
cat("\nMissing values per column:\n")
print(colSums(is.na(data)))

# Categorical columns
cat("\nCategorical columns:\n")
categorical_cols <- names(data)[sapply(data, is.character)]
print(categorical_cols)

# Summary stats
summary(select(data, Age, Balance, CreditScore, EstimatedSalary))

# Plot: Age distribution
ggplot(data, aes(x = Age)) +
  geom_histogram(bins = 30, fill = "lightblue", color = "black") +
  labs(title = "Distribution of Customer Age", x = "Age", y = "Frequency")

# Plot: Geography
ggplot(data, aes(x = Geography)) +
  geom_bar(fill = "skyblue", color = "black") +
  labs(title = "Customer Distribution by Geography", x = "Country", y = "Count")

# Plot: Target variable
ggplot(data, aes(x = factor(Exited))) +
  geom_bar(fill = "tomato", color = "black") +
  labs(title = "Distribution of Target Variable: Exited", x = "Exited (0 = No, 1 = Yes)", y = "Count")

# ============================================================
# STEP 2: DATA PREPARATION
# ============================================================

data <- data %>%
  select(-id, -CustomerId, -Surname) %>%
  mutate(Exited = as.factor(Exited))

set.seed(123)
split <- initial_split(data, prop = 0.8, strata = Exited)
train_data <- training(split)
test_data <- testing(split)

# ============================================================
# STEP 3: PREPROCESSING AND MODEL WORKFLOW
# ============================================================

xgb_recipe <- recipe(Exited ~ ., data = train_data) %>%
  step_novel(all_nominal_predictors()) %>%
  step_dummy(all_nominal_predictors()) %>%
  step_zv(all_predictors()) %>%
  step_normalize(all_numeric_predictors()) %>%
  step_smote(Exited)

xgb_spec <- boost_tree(
  trees = tune(),
  tree_depth = tune(),
  learn_rate = tune(),
  loss_reduction = 0.01,
  sample_size = 0.8,
  mtry = tune()
) %>%
  set_engine("xgboost") %>%
  set_mode("classification")

xgb_wf <- workflow() %>%
  add_recipe(xgb_recipe) %>%
  add_model(xgb_spec)

# ============================================================
# STEP 4: TUNING
# ============================================================

set.seed(42)
folds <- vfold_cv(train_data, v = 5, strata = Exited)

prepped <- prep(xgb_recipe)
n_predictors <- length(prepped %>% juice() %>% select(-Exited) %>% colnames())

xgb_grid <- grid_space_filling(
  trees(range = c(300, 1000)),
  tree_depth(range = c(3, 10)),
  learn_rate(range = c(-3, -0.5)),
  mtry(range = c(2, n_predictors)),
  size = 6
)

xgb_tune <- tune_grid(
  xgb_wf,
  resamples = folds,
  grid = xgb_grid,
  control = control_grid(save_pred = TRUE, verbose = TRUE, allow_par = FALSE),
  metrics = metric_set(accuracy, roc_auc)
)

# Save best parameters
best_params <- select_best(xgb_tune, metric = "roc_auc")
saveRDS(best_params, "best_params.rds")
show_best(xgb_tune, metric = "roc_auc")

# ============================================================
# STEP 5: FINAL MODEL TRAINING
# ============================================================

final_wf <- finalize_workflow(xgb_wf, best_params)
final_model <- final_wf %>% fit(data = data)


plot5<-final_model %>%
  extract_fit_parsnip() %>%
  vip(
    num_features = 11,
    geom = "point",
    horizontal = TRUE,
    aesthetics = list(color = "black", size = 3)
  ) +
  labs(title = "Variable Importance XGBoost  ")

install.packages("cowplot")
library(cowplot)

plot_grid(plot1, plot2, plot3, plot4, plot5,
          ncol = 2, nrow = 3) 

# ============================================================
# STEP 6: PREDICT ON test.csv FOR KAGGLE SUBMISSION
# ============================================================

test_raw <- read_csv("test.csv")
sample_submission <- read_csv("sample_submission.csv")

test_data <- test_raw %>%
  select(-CustomerId, -Surname)

test_probs <- predict(final_model, new_data = test_data, type = "prob")

submission <- sample_submission %>%
  mutate(Exited = test_probs$.pred_1)

write_csv(submission, "submission.csv")

# ✅ submission.csv is now ready for Kaggle submission

