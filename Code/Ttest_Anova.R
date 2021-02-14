Package_Pricing_at_Mission_Hospital_Data_Supplement <- read_excel("D:/study stuff/UIC/Sem - 2/IDS 594 Healthcare/Assignment - 9 Mission Hospitals/Package Pricing at Mission Hospital - Data Supplement.xlsx", 
                                                                  +     sheet = "MH-Modified Data")

data<-Package_Pricing_at_Mission_Hospital_Data_Supplement
data$`KEY COMPLAINTS -CODE` <-as.factor(data$`KEY COMPLAINTS -CODE`)

summary(data$`KEY COMPLAINTS -CODE`)

library(dplyr)
data<- as.data.frame(mutate(data, AGE_cat = ifelse(AGE<=10,"child",ifelse(AGE<=25,"young_adult",ifelse(AGE<=50,"adult","old")))))
data<- as.data.frame(mutate(data, ))
data$AGE_cat
attach(data)
data<- as.data.frame(mutate(data, BP_cat = 
                              ifelse(data$`BP -HIGH` <=120 & data$`BP-LOW` <=80,"Normal",
                                     ifelse(data$`BP -HIGH` <=130 & data$`BP-LOW` <=80,"Elevated",
                                            ifelse(data$`BP -HIGH` <=140 & data$`BP-LOW` <=90,"pre-highBP","HighBP")))))
sum(is.na(data$BP_cat))

library(dplyr)
data<- as.data.frame(mutate(data, UREA_cat = ifelse(UREA %in% 7:20,"Normal","Abnormal" )))

t.test(data$AGE_cat data$`TOTAL LENGTH OF STAY` )

anova_oneway <- aov(data$`TOTAL LENGTH OF STAY`~data$AGE_cat, data = data)
summary(anova_oneway)
TukeyHSD(anova_oneway)


anova_oneway <- aov(data$`TOTAL COST TO HOSPITAL`~data$AGE_cat, data = data)
summary(anova_oneway)
tapply(data$`TOTAL COST TO HOSPITAL`,data$AGE_cat, summary)
TukeyHSD(anova_oneway)

tapply(data$`TOTAL LENGTH OF STAY`,data$AGE_cat, summary)

BPnulls<- data[is.na(data$`BP -HIGH` ),]
summary(BPnulls)



BPnotnulls<- data[!is.na(data$`BP -HIGH` ),]
summary(BPnotnulls)
