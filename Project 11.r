options(jupyter.rich_display = F)
options(repr.matrix.max.cols=100, repr.matrix.max.rows=200)
library(data.table)
county<- fread("/anvil/projects/tdm/data/zillow/County_time_series.csv")
# i input that data set into the variables called county

dim(county)
# to see what it contain
# it has 518791 rows     82 columns

library(lubridate)
# not an error but telling us the various varriable that are in it

head(county)
head(county$Date)
#it has the format in year, month and day. 

month(head(county$Date))
# i can go in and pull off the month

day(head(county$Date))
# i can go in and pull off the day

year(head(county$Date))
# i can go in and pull off the day

tail(county$Date)
# i can check with the tail either way.

month(tail(county$Date))
day(tail(county$Date))
year(tail(county$Date))
# to check with the tail, just to verify

county$month <- month(county$Date)
# all of the date column is converted to month
# and it is save in a new column called month and my data frame

county$day <- day(county$Date)
# i will create the same for day

county$year <- year(county$Date)
head(county)

county$mdy <- paste0(county$month, "/", county$day, "/", county$year)
# i could make a column called mdy (county$mdy)
# to do that, i could paste together
# new column is created called mdy

table(county$year)
# to know the number of year in the data frame

length(table(county$year))
# to know the total number, just take the length

head(county$MedianListingPricePerSqft_3Bedroom)
# a lot of them are NA

tail(county$MedianListingPricePerSqft_3Bedroom)
# take a look at the tail
# it has actual values

tapply(county$MedianListingPricePerSqft_3Bedroom, county$year, mean)
# take the data in there, split it up according to year and then take the mean
# i get all NA's because every year has some NA values

tapply(county$MedianListingPricePerSqft_3Bedroom, county$year, mean, na.rm=TRUE)
# i will remove NA's
# it is obvious from 1996 - 2009, i don't have any value.
# the mean calculated were from 2010 - 2017.

tapply(county$MedianListingPricePerSqft_3Bedroom, county$year, mean, na.rm=TRUE)
# i will remove NA's
# it is obvious from 1996 - 2009, i don't have any value.
# the mean calculated were from 2010 - 2017.

tapply(county$MedianListingPricePerSqft_1Bedroom, county$year, mean, na.rm=TRUE)
f <- tapply(county$MedianListingPricePerSqft_3Bedroom, county$year, mean, na.rm=TRUE)
k <- tapply(county$MedianListingPricePerSqft_1Bedroom, county$year, mean, na.rm=TRUE)

plot(names(f), f, type = "l")
lines (names (k), k,type = "l")
# names(f) - which is the year, f - numerical values
# i can plot on top of f by changing it to line
# from the shape seen, the difficulties is that the limit on the y values are set by the first outcome there.
# for the f we have its ylimit from (0 - 128.3419), while k has ylimit from (o -271.7585)
# f ylimit will now be increased to from 0 -300 to accomodate that

plot(names(f), f, type = "l", ylim=c(0,300),main="average value per year of MedianListingPrice", xlab= "MedianListingPrice", col= c("red"))
lines (names (k), k,type = "l",col= c("orange"))

# Write one to two sentences on what you notice in the graph

# The graph of k(MedianListingPricePerSqft_1Bedroom)has more dip/steppy than that of f(MedianListingPricePerSqft_3Bedroom), It depict high price for    k(MedianListingPricePerSqft_1Bedroom) graph reflecting inflation for small size of bedroom

names(county)
# i want the ones that has tier in them

grep("ier",names (county))
# to look for tier, i dont know if the t is capitalised or not, therefore, i will look for the ones with "ier"
# i found 3 columns that have ier in them

names (county)[grep("ier",names (county))]
# to extract their actual names

head(county$ZHVI_BottomTier)

head(county$ZHVI_MiddleTier)

head(county$ZHVI_TopTier)

tapply(county$ZHVI_TopTier,county$year, mean, na.rm=TRUE)
# in order to know what is interesting about the data, you need to plot.

v <-tapply(county$ZHVI_TopTier,county$year, mean, na.rm=TRUE)

plot(names(v), v, type = "l")

plot(names(v), v, type = "l",main="average value per year of the median prices of top tier homes", 
     xlab= "the median prices of top tier homes", col= c("purple"))

tapply(county$ZHVI_BottomTier,county$year, mean, na.rm=TRUE)["2014"]
# to extract for the year 2014 only

mean(county$ZHVI_BottomTier[county$year=="2014"], na.rm=TRUE)
# another way of doing it

tapply(county$ZHVI_BottomTier,county$year, mean, na.rm=TRUE)["2010"]
mean(county$ZHVI_BottomTier[county$year=="2010"], na.rm=TRUE)

# tapply(some data here, how to break up the data, a function to apply to each piece of the data)

# Write a sentence or two about anything that may seem interesting about this data. it started increasing from year 1996 until year 2010 with            reduction and pick up again in the year 2014 till year 2017. If related to economy or sales, the progress flunctuate.

v <-tapply(county$ZHVI_TopTier,county$year, mean, na.rm=TRUE)

v

w <-tapply(county$ZHVI_MiddleTier,county$year, mean, na.rm=TRUE)

w

x <-tapply(county$ZHVI_BottomTier,county$year, mean, na.rm=TRUE)

x

max(v)
max(w)
max(x)
# because of the ranges of values , i will make ylimit to go from 0 - 300000


plot(names(v), v, type = "l", ylim = c(0,300000),main="average per year of each of the three columns", 
     xlab= "bottomTier, middleTier and topTier", col= c("purple"))
lines(names(w), w, type = "l",col= c("orange"))
lines(names(x), x, type = "l",col= c("red"))

#  Can you create a graph that shows the average per year of each of the three columns (bottom tier, middle tier, and top tier), so that you can        easily compare these variables?

# Their curves are almost same shape but more steepy with v, they follow simmilar pattern of increasing and decreasing but more impact with v.

head(county$MedianRentalPrice_1Bedroom)
tail(county$MedianRentalPrice_1Bedroom)

tapply(county$MedianRentalPrice_1Bedroom, county$year, mean)

tapply(county$MedianRentalPrice_1Bedroom, county$year, mean, na.rm=TRUE)

tapply(county$MedianRentalPrice_2Bedroom, county$year, mean, na.rm=TRUE)

tapply(county$MedianRentalPrice_3Bedroom, county$year, mean, na.rm=TRUE)

a <- tapply(county$MedianRentalPrice_1Bedroom, county$year, mean, na.rm=TRUE)

a

b<- tapply(county$MedianRentalPrice_2Bedroom, county$year, mean, na.rm=TRUE)