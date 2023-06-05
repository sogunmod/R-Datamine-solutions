options(jupyter.rich_display = F)
list.files("/anvil/projects/tdm/data/disney")
myDF <- read.csv("/anvil/projects/tdm/data/disney/7_dwarfs_train.csv", stringsAsFactors = TRUE)
dim(myDF)
str(myDF)
# 'data.frame':	321631 obs. of  4 variables:
#  $ date    : Factor w/ 2334 levels "01/01/2015","01/01/2016",..: 1 1 1 1 1 1 1 1 1 1 ...
#  $ datetime: Factor w/ 321586 levels "2015-01-01 07:51:12",..: 1 2 3 4 5 6 7 8 9 10 ...
#  $ SACTMIN : int  NA NA 54 NA NA 55 NA NA NA NA ...
#  $ SPOSTMIN: int  45 60 NA 60 60 NA 60 60 90 105 ...

#  There are 321631 Rows and 4 Columns. Date and datetime has Factor while SACTMIN & SPOSTMIN has integers.

head(myDF$SPOSTMIN)
table(myDF$SPOSTMIN, useNA="always")
# -999     0     5    10    15    20    25    30    35    40    45    50    55 
23062    32   897  1306   914  3638  2166 13939  4894 14941 15149 19555  6989 
   60    65    70    75    80    85    90    95   100   105   110   115   120 
29034 10345 23496 12101 22971  5301 23813  6853 10773  8164 11909  3000 13097 
  125   130   135   140   145   150   155   160   165   170   175   180   185 
 1954  5982  1723  4151   940  3793   394  1739   520  1031   272  1644   163 
  190   195   200   205   210   215   220   225   230   235   240   250   260 
  375   128   249   100   257    11    88    26    26    17    37    17    10 
  270   280   300  <NA> 
    6     2     2  7635 

summary(myDF$SPOSTMIN)
#  Min.  1st Qu.   Median     Mean  3rd Qu.     Max.     NA's 
-999.000   45.000   70.000   -2.064   95.000  300.000     7635 

#  A. The increment of time are in multiples of 5's. The types of values that appear, Minimum time is -999.000, 25% of the values are < 45, 50% of the values are < 70, 75% of the values are 95, Maximum time is 300 and the mean is -ve (-2.064) probably due to manual coding or missisng values  The different wait time options are seven, Minimum, Ist quater, Median, Mean, 3rd Quater, Maximum and NA'S.

# B. The NA values in "SPOSTMIN" are, 7635

newDF <- subset(myDF, !is.na(myDF$SPOSTMIN))

 date       datetime            SACTMIN SPOSTMIN weekday
# 1 01/01/2015 2015-01-01 07:51:12 NA      45       Thu       
# 2 01/01/2015 2015-01-01 08:02:13 NA      60       Thu      
# 4 01/01/2015 2015-01-01 08:09:12 NA      60       Thu      
# 5 01/01/2015 2015-01-01 08:16:12 NA      60       Thu       
# 7 01/01/2015 2015-01-01 08:23:12 NA      60       Thu     
# 8 01/01/2015 2015-01-01 08:29:12 NA      60       Thu   

mean((myDF$SACTMIN[myDF$date == "12/25/2021"]), na.rm=TRUE)
mean((myDF$SACTMIN[myDF$date == "07/26/2021"]), na.rm=TRUE)

# On Christmas day, the average waiting time is 48. On July 26th, the average waiting time is 39.6.

# summer in 2021
mean((myDF$SACTMIN[myDF$date == "08/10/2021"]), na.rm=TRUE)

#labour day holiday , 2021
mean((myDF$SACTMIN[myDF$date == "09/06/2021"]), na.rm=TRUE)

# There is a difference between the wait times in the summer and the holidays.

head(sort(table(myDF$date), decreasing = TRUE), n = 10)

# 11/08/2021 10/01/2021 11/09/2021 10/29/2021 10/15/2021 10/10/2021 10/05/2021 
       363        359        344        333        332        330        329 
# 10/17/2021 10/20/2021 10/08/2021 
       327        327        323 


# The most entries occur on 11/08/2021 on the data set.

length(myDF$SPOSTMIN)

length(newDF$SPOSTMIN)

# The lengths of the column "SPOSTMIN" in the myDF and newDF were  321631 & 313996.



# divide the whole sytax by 60.
# we put the head because we want to see the whole values.
(head(myDF$SPOSTMIN) + head(newDF$SPOSTMIN))/60

myhours <- (myDF$SPOSTMIN + newDF$SPOSTMIN)/60

length(myhours)

#The length of the new vector myhours is 321631.

myDF$SPOSTMIN[313997]/60

newDF$SPOSTMIN[1]/60 # this vector is out of data , so we will start over again at the begining.
# this is called recycling.

myhours[313997]

# At row 313997, newDF$SPOSMIN was out of data and shows NA. So we started aover again because of recycling.

mean(myDF$SACTMIN[myDF$weekday =="Mon"]) 
# there are some NA values, we can throw it away.
# [1] NA

head(sort(myDF$SACTMIN))
# [1] -92918      0      0      0      0      0


# monday is the day of the week when we are expect to have the longest waiting time for the ride.

mean(myDF$SACTMIN[(myDF$weekday =="Mon") & (myDF$SACTMIN !=-92918)], na.rm=TRUE) 
# this help to eliminate the negation.
# [1] 37.92959


# tapply function, needs three pieces of data.
# 1. needs the data you want to work on
# 2. needs to know how you want to break the data into groups 
# 3. needs to know what you want to do to each group of the data
# note: any options for that thing you want to do to the data can be given at the end

tapply(myDF$SACTMIN, myDF$weekday, mean,  na.rm=TRUE)

#      Sun       Mon       Tue       Wed       Thu       Fri       Sat 
 34.90372 -72.86412  34.55502  36.44053  36.17215  36.12491  37.73216 

# we can fix the Monday values this way : by putting this restriction on all of our data.  myDF$SACTMIN !=-92918

tapply(myDF$SACTMIN[myDF$SACTMIN !=-92918], myDF$weekday[myDF$SACTMIN !=-92918], mean,  na.rm=TRUE)

  #  Sun      Mon      Tue      Wed      Thu      Fri      Sat 
#  34.90372 37.92959 34.55502 36.44053 36.17215 36.12491 37.73216 

#  Monday is the day of the week in myDF that has the longest average wait times,37.92959.


myresults <- tapply(myDF$SACTMIN[myDF$SACTMIN !=-92918], myDF$weekday[myDF$SACTMIN !=-92918], mean,  na.rm=TRUE)
plot(myresults)

dotchart(myresults)

#  The dotchart illustrates the data for the average wait times better because the days of the week and and it is easily traceable.

myDF$month <- month(myDF$datetime, label=TRUE)

head(myDF)

tapply(myDF$SACTMIN[myDF$SACTMIN !=-92918], myDF$month[myDF$SACTMIN !=-92918], mean,  na.rm=TRUE)

#  Jan      Feb      Mar      Apr      May      Jun      Jul      Aug 
#  41.64757 43.62733 38.50000 34.66873 35.36293 39.98100 36.83942 32.08961 
#     Sep      Oct      Nov      Dec 
#  26.98632 33.45165 37.98672 37.74623 

#  February is the month of the year in myDF that has the longest average wait times, 43.62733.


mymonthresults <- tapply(myDF$SACTMIN[myDF$SACTMIN !=-92918], 
                         myDF$month[myDF$SACTMIN !=-92918], mean,  na.rm=TRUE)

plot(mymonthresults) 

dotchart(mymonthresults) 

# The dotchart illustrates the data for the average wait times better because it the Months of the year and and it is easily traceable.
