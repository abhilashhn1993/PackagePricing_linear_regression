# Package-Pricing-At-Mission-Hospital
Built Predictive Model to estimate the price of treatment given the clinical factors at the time of admission.

### TABLE OF CONTENTS
* [Objective](#objective)
* [Conceptual-Model](#conceptual-model)
* [Data-Preparation](#data-preparation)
* [Statistical-Tests](#Statistical-Tests)
* [Model](#model)
* [References](#references)

## OBJECTIVE

Estimate the price of treatment given the clinical factors at the time of admission

## CONCEPTUAL-MODEL 

<img src="https://github.com/skotak2/Package-Pricing-At-Mission-Hospital/blob/main/Images/Conceptual_Model.JPG" width="800" height="400">

## Data Preparation

### Removed the following columns with insufficient observations as "1"

* CAD SVD
* CAD VSD
* Other general
* Confused state

### Numerical values were bucketed and One hot encoded for the following variables,

* Age Categories - <10, 11 25, 26 50, 50 and above (as per domain expertise)
* BP Ranges - Low, Normal, High, Critical (as per the medical charts)
* BMI - Underweight, Normal, Overweight, Obese (as per the medical charts)
* Hemoglobin "normal": Female 12 to 15.5, Men 13 to 17.5, any value outside these limits will be "abnormal"
* Urea "normal": 7 to 20 mg/dl any value outside these limits will be "abrnormal"

### Removing Variables based on avalability of data

* Removed the variable - "Stay at hospital ICU and Ward".It is a reflective construct variable. Its not possible to predict the length of stay, accurately at the time of admission to compute total treatment cost.

The below graphs illustrates on the correlation between target variable and Hospital Admission - both at Intensive Care Unit and Normal care unit

<img src="https://github.com/skotak2/Package-Pricing-At-Mission-Hospital/blob/main/Images/ICU_high_Cor.JPG" width="800" height="400">

* Considered ln(Total Cost) instead of Total Cost to Hospital(INR). The total cost value variable has a right skew. Taking the log would make the distribution of our transformed variable appear more symmetric.

From the below graphs we see that the data is normalized by taking the logarthmic value of the variable,

<img src="https://github.com/skotak2/Package-Pricing-At-Mission-Hospital/blob/main/Images/Skew_target_var.JPG" width="800" height="400">


### Handling NULL Values

* BP Ranges Imputed 'Normal' BP range for null values which were Juvenile Patients
* Urea Imputed 'Normal' Urea level for 11 null values. Assumption: Urea measurement is not critical for that patient.

## Statistical-Tests

T-Test and Anova was performed on specific variable to understand their effect on target variable. Code is available [here](https://github.com/skotak2/Package-Pricing-At-Mission-Hospital/blob/main/Code/Ttest_Anova.R)

T test was performed on variables with 2 categories. The following variables were removed as they proved insignificant,

* other-heart
* other-nervous
* other-tetralogy
* Diabetes
* Hypertension
* Hemoglobin

ANOVA test was done to test for variables with more than two levels and the following variables proved significant,

* Age 
* BMI
* BP Ranges


New categorical variables were derived flagging subjects with multiple health issues. The following are the conditions that were hypothesized based on domain expertise, and T-test was performed

<img src="https://github.com/skotak2/Package-Pricing-At-Mission-Hospital/blob/main/Images/interactions.JPG" width="400" height="400">


## Model

Click here for the [code](https://github.com/skotak2/Package-Pricing-At-Mission-Hospital/blob/main/Code/Data_prep_modelling.R)

* Logistic Regression Model to understand the relation between target variable and body weight as the predictor variable, (this use case was based on the domain expert's requirement)

<img src="https://github.com/skotak2/Package-Pricing-At-Mission-Hospital/blob/main/Images/body_weight.JPG" width="800" height="400">

* Logistic Regression Model to understand the relation between target variable and feature engineered variables,

<img src="https://github.com/skotak2/Package-Pricing-At-Mission-Hospital/blob/main/Images/intrepretation.JPG" width="400" height="400"><img src="https://github.com/skotak2/Package-Pricing-At-Mission-Hospital/blob/main/Images/model_all_vars.JPG" width="400" height="400">

## References

* http ://www.bloodpressureuk.org/BloodPressureandyou/ Bloodpressurechart

* https ://www.mayoclinic.org/tests procedures/blood urea nitrogen/about/ pac 20384821

* https ://www.quora.com/Why do we log variables in regression model






