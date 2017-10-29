#use the Ames, Iowa data set to understand difference between confidence and prediction intervals
library(mice)
library(caTools)

#setwd(Set the working directory to the location that contain train.csv)
dataset = read.csv('train.csv')

#pick only LotArea and SalePrice
houseprice = data.frame(dataset$LotArea,
                        dataset$SalePrice)

colnames(houseprice) = c('LotArea', 'SalePrice')

#check for missing data
md.pattern(houseprice)

#split the data into training and test set
set.seed(5)
split = sample.split(Y = houseprice$SalePrice,
                     SplitRatio = 0.9)
training_set = subset(houseprice, split == TRUE)
test_set = subset(houseprice, split == FALSE)

#build the multiple linear regression using training set
houseprice_linreg = lm(formula = SalePrice ~ .,
                         data = training_set)
summary(houseprice_linreg)

#predict the house prices of the test set
print(test_set[1,1])

y = 159751.318 + 2.078 * 8246
print(y)

y_pred_confidence = predict(houseprice_linreg, 
                 newdata = data.frame(LotArea = test_set[1,1]),
                 interval = 'confidence')
print(y_pred_confidence)

y_pred_prediction = predict(houseprice_linreg, 
                            newdata = data.frame(LotArea = test_set[1,1]),
                            interval = 'prediction')
print(y_pred_prediction)



