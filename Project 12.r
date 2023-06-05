options(jupyter.rich_display = F)
options(repr.matrix.max.cols=100, repr.matrix.max.rows=200)
library(data.table)
state <-fread("/anvil/projects/tdm/data/zillow/State_time_series.csv")

class(state$Date)
typeof(state$Date)
str(state)
head(state$Date)

# Are there multiple functions that will return the same or similar information? There are different output from each command use.

library(lubridate)
head(state$Date)

class(head(state$Date))
# before we have this.

ymd(head(state$Date))
# running ymd function 

class(ymd(head(state$Date)))
# but after introducing ymd it changes
# to know the class it belongs to

state$newdates <- ymd(state$Date)
# to make a whole new column call newdates

head(state$newdates)
# i just got the date now and the date class

wday(head(state$newdates), label=TRUE)

wday(tail(state$newdates), label=TRUE)

state$day_of_the_week <- wday(state$newdates, label=TRUE)

table(state$day_of_the_week)

state$day_of_the_week_as_number <- wday(state$newdates)

table(state$day_of_the_week_as_number )
# Sunday is day1, Monday is day2,........Saturday is day7

head (state$DaysOnZillow_AllHomes)
# it has lot of NA's

tail (state$DaysOnZillow_AllHomes)
# it has lot of NA's

summary(state$DaysOnZillow_AllHomes)
# then look for the summary
#  this shows different ranges

head(state$newdates)
# look at the head of the new dates we created.

month(head(state$newdates))
# to pull out the month that are there

state$month <- month((state$newdates))
# to make a month column that has all the months entries

tapply(state$DaysOnZillow_AllHomes,state$month, mean )
# do a tapply looking at the number of day on Zillow all homes, break it down into months and then find the average
# it has lot of NA's

tapply(state$DaysOnZillow_AllHomes,state$month, mean, na.rm= T )
# to remove NA"s
# this shows month by month, how many days on Zillow there are on average. 

barplot(tapply(state$DaysOnZillow_AllHomes,state$month, mean, na.rm= T), names.arg= month.abb, col= "red", 
        main= "Average number of days on Zillow", ylab= "Number of days")
# names there be the month of abbreviation (names.arg= month.abb)


# We want to see if there is a better month(s) for putting our house on the market?
# Use tapply to compare the average DaysOnZillow_AllHomes for all months. 

# for the winter and fall months there is low sales while high sales in summer months.

state$year <- year((state$newdates))
# make a year column first

state2017 <- subset(state, year==2017)
# take the state data frame and break it according to year there.

tapply(state2017$DaysOnZillow_AllHomes,state2017$newdates, mean, na.rm=T)
# since there are lot of NA's. i will remove them

plot(tapply(state2017$DaysOnZillow_AllHomes,state2017$newdates, mean, na.rm=T))
# by the default we have dots

plot(tapply(state2017$DaysOnZillow_AllHomes,state2017$newdates, mean, na.rm=T), 
     type= "l", col = "purple", main = "Average number of days on Zillow for 2017" )
# for line plot, to turn it into a line

# What do you notice? 
# There are lot of houses during winter and fall implies that the demands are low in that period but houses are scarce during summer meaning demand will be high for houses.
# When was the best month/months for posting a home for sale in 2017? 
# The best month is the month of June.


head (state$RegionName)
# the region name

table(state$RegionName)

IndianaDF <- subset(state2017, RegionName == "Indiana" )

MaineDF <- subset(state2017, RegionName == "Maine" )

HawaiiDF <- subset(state2017, RegionName == "Hawaii" )

dim(IndianaDF)

dim(MaineDF)

dim(HawaiiDF)
# since i got same value of 12 rows and 87 columns for every states
# very likely one row there per month

plot(IndianaDF$newdates,IndianaDF$DaysOnZillow_AllHomes, type = "l", col = "orange" )
# IndianaDF$DaysOnZillow_AllHomes is for y axis, 
# we are having several different plot, for each state, then we will put different color

min(state2017$DaysOnZillow_AllHomes, na.rm=T)
# i want to make sure that i get my ylim values correct
# this is the ylim minimum value

max(state2017$DaysOnZillow_AllHomes, na.rm=T)
# this is the ylim maximum value

plot(IndianaDF$newdates,IndianaDF$DaysOnZillow_AllHomes, type = "l", col = "orange", 
     ylim = c(min(state2017$DaysOnZillow_AllHomes, na.rm=T), max(state2017$DaysOnZillow_AllHomes, na.rm=T)))
# new plot for Indiana after adjusting the ylim

plot(MaineDF $newdates,MaineDF $DaysOnZillow_AllHomes, type = "l", col = "red", 
     ylim = c(min(state2017$DaysOnZillow_AllHomes, na.rm=T), max(state2017$DaysOnZillow_AllHomes, na.rm=T)))

plot(HawaiiDF$newdates,HawaiiDF$DaysOnZillow_AllHomes, type = "l", col = "purple", 
     ylim = c(min(state2017$DaysOnZillow_AllHomes, na.rm=T), max(state2017$DaysOnZillow_AllHomes, na.rm=T)))




plot(IndianaDF$newdates,IndianaDF$DaysOnZillow_AllHomes, type = "l", col = "orange", 
     ylim = c(min(state2017$DaysOnZillow_AllHomes, na.rm=T), max(state2017$DaysOnZillow_AllHomes, na.rm=T))
    )
lines(MaineDF $newdates,MaineDF $DaysOnZillow_AllHomes, type = "l", col = "red", 
     ylim = c(min(state2017$DaysOnZillow_AllHomes, na.rm=T), max(state2017$DaysOnZillow_AllHomes, na.rm=T))
    )
lines(HawaiiDF$newdates,HawaiiDF$DaysOnZillow_AllHomes, type = "l", col = "purple", 
     ylim = c(min(state2017$DaysOnZillow_AllHomes, na.rm=T), max(state2017$DaysOnZillow_AllHomes, na.rm=T))
     )
legend( "topright", legend = c ("Indiana", "Maine", "Hawaii"), lwd = 2, col = c("orange", "red", "purple"))

# to have them all on the same line, and also with legend.
# it will plot that of plot and have the lines on it.
# my line width (lwd) is 2      




plot(IndianaDF$newdates,IndianaDF$DaysOnZillow_AllHomes, type = "l", col = "orange", 
     ylim = c(min(state2017$DaysOnZillow_AllHomes, na.rm=T), max(state2017$DaysOnZillow_AllHomes, na.rm=T))
    )
lines(MaineDF $newdates,MaineDF $DaysOnZillow_AllHomes, type = "l", col = "red", 
     ylim = c(min(state2017$DaysOnZillow_AllHomes, na.rm=T), max(state2017$DaysOnZillow_AllHomes, na.rm=T))
    )
lines(HawaiiDF$newdates,HawaiiDF$DaysOnZillow_AllHomes, type = "l", col = "purple", 
     ylim = c(min(state2017$DaysOnZillow_AllHomes, na.rm=T), max(state2017$DaysOnZillow_AllHomes, na.rm=T))
     )
legend( "topright", legend = c ("Indiana", "Maine", "Hawaii"), lwd = 2, col = c("orange", "red", "purple"), ncol=2, cex = .9)

# ncol = 2, means to split the column into two incase of several list
# cex = .9 means to change the size to whatever size you desire.