MissionHospital <- read_excel("D:/study stuff/UIC/Sem - 2/IDS 594 Healthcare/Assignment - 9 Mission Hospitals/MissionHospital.xlsx", sheet = "MissionHospital")
View(MissionHospital)

data <- as.data.frame(MissionHospital)
attach(data)
str(data)
columns_to_delete <- c("MARRIED","CAD-VSD","other-general","BODY HEIGHT","ALERT","TRANSFERRED","ELECTIVE","LENGTH OF STAY - ICU","LENGTH OF STAY- WARD","IMPLANT","TOTAL COST TO HOSPITAL","TOTAL LENGTH OF STAY")



train <- data[,-which(names(data) %in% columns_to_delete)]
colnames(train)
str(train)
chr_indx <- c(2:13,19:24,28)
for (i in chr_indx) {
  train[[i]] <- as.factor(train[[i]])
}
str(train)


str(data)
#Age Group
data$AGE_GROUP[data$AGE<=10]="child"
data$AGE_GROUP[data$AGE>10 & data$AGE<=25]="youngadult"
data$AGE_GROUP[data$AGE>26 & data$AGE<=50]="adult"
data$AGE_GROUP[data$AGE>=50]="old"

#Missing values handling
data$HB[data$HB==NA]="-1"
data$UREA[data$UREA==NA]="-1"
data$`BP -HIGH`[data$`BP -HIGH`==NA]="-1"
data$`BP-LOW`[data$`BP-LOW`==NA]="-1"
data$CREATININE[data$CREATININE==NA]="-1"

#CREATININE_LEVEL

data$CREATININE_LEVEL[data$AGE<=3 & data$CREATININE>=0.3 &data$CREATININE<=0.7 ]="NORMAL"
data$CREATININE_LEVEL[data$AGE>3 & data$AGE<=18 & data$CREATININE>=0.5 &data$CREATININE<=1.0 ]="NORMAL"
data$CREATININE_LEVEL[data$AGE>18 & data$FEMALE==1 & data$CREATININE>=0.6 &data$CREATININE<=1.1 ]="NORMAL"
data$CREATININE_LEVEL[data$AGE>18 & data$FEMALE==0 & data$CREATININE>=0.9 &data$CREATININE<=1.3 ]="NORMAL"
data$CREATININE_LEVEL[is.na(data$CREATININE_LEVEL)]<-"NOTNORMAL"

#Haemoglobin
data$HB_LEVEL[data$HB<11]<-"LOW"
data$HB_LEVEL[data$HB>=11]<-"NORMAL"

cor(data[,is.numericda])

#BMI
data$BMI[data$`BODY WEIGHT`/'^'((data$`BODY HEIGHT`/100),2)<=18.5]="UNDERWEIGHT"
data$BMI[data$`BODY WEIGHT`/'^'((data$`BODY HEIGHT`/100),2)>18.5 & data$`BODY WEIGHT`/'^'((data$`BODY HEIGHT`/100),2)<25]="NORMAL"
data$BMI[data$`BODY WEIGHT`/'^'((data$`BODY HEIGHT`/100),2)>=25 & data$`BODY WEIGHT`/'^'((data$`BODY HEIGHT`/100),2)<30]="OVERWEIGHT"
data$BMI[data$`BODY WEIGHT`/'^'((data$`BODY HEIGHT`/100),2)>=30]="OBESE"

#REMOVING OUTLIER BMIs
data<-data[!(data$`BODY WEIGHT`/'^'((data$`BODY HEIGHT`/100),2)>100),]

#Blood pressure categories
data$BP_Cat[data$`BP -HIGH`<120 & data$`BP-LOW`<80]<- "normal"
data$BP_Cat[(data$`BP -HIGH`>119 & data$`BP-LOW`<130) & data$`BP-LOW`<80]<- "elevated"
data$BP_Cat[(data$`BP -HIGH`>129 & data$`BP -HIGH`<140) | (data$`BP-LOW`>79 & data$`BP-LOW`<90)]<- "high1"
data$BP_Cat[data$`BP -HIGH`>= 140 | data$`BP-LOW`>=90]<- "high2"
data$BP_Cat[data$`BP -HIGH`> 180 | data$`BP-LOW`>120]<- "crisis"

#modelling
linear <- lm(`Ln(Total Cost)` ~ .+ AGE*UREA*`BODY WEIGHT`*`BODY HEIGHT`, data = train)
summary.fit<- summary(linear)
summary.fit


options(scipen = 999)
linear <- lm(`Ln(Total Cost)` ~ Diabetes1+`Diabetes2`+`hypertension1`+`hypertension2`+`hypertension3`+`other`+`BODY WEIGHT`+`BODY HEIGHT`+`AGE`+`FEMALE`+`ACHD`+`CAD-DVD`+`CAD-SVD`+`CAD-TVD`+`OS-ASD`, data = train)
summary.fit<- summary(linear)
summary.fit
exp(summary.fit$coefficients[,1])

