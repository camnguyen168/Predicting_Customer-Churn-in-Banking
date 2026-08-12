# Predicting Banking Customer Churn (Classification Problem)

This Project implemented various machine learning model to predict customer who will churn. The phenomenon of customer churn, known as “churn,” i.e., the transition from one service provider to another occurs due to reasons such as availability of the latest technology, bank staff are friendly to customers, low interest rates, close geographical location, diverse services offered.The analysis of bank customer churn can reflect which factors affect the customer’s choice of retention, and in the later stage, it can provide corresponding solutions and plans to guarantee the bank’s income. The accurate customer prediction helps the company to persuade the appropriate customer to stay at the right time.

# Models:

- Parametric Models: Logistic Regression, Ridge
- Non Parametric Model: Decision Tree, Random Forest, XG Boost

# Process:
- Data Preprocessing: One Hot encoding,Smote,StandardScalar
- Exploratory Data Analysis
- Model Implementation: Building and tuning models
- Model Evaluation: Accuracy, Precision, AUC,..
- Interpretability: LIME, Permutation Feature Importance

  

# Result
XG Boost receiced the highest AUC, 
Age and number of product are the important variables to predict customer churn.

Feature importance indicates how strongly a variable contributes to model predictions; it does not establish that the feature causes churn (causality). Retention decisions should therefore combine model predictions with business context.

Code: R and Python

Supervised by: Prof. Hibbeln and Noah Urban
