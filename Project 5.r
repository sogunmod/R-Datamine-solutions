options(jupyter.rich_display = F)

options(repr.matrix.max.cols=25, repr.matrix.max.rows=200)

myDF <- read.csv("/anvil/projects/tdm/data/election/escaped/itcont2020sample.txt", sep="|")

head(myDF)

class(myDF$ TRANSACTION_DT)
 # [1] "integer"

library(lubridate)

library(lubridate, warn.conflicts = FALSE)

mdy(head(myDF$TRANSACTION_DT))

class(mdy(head(myDF$TRANSACTION_DT)))
# with mdy the class is date, while before it was integer.
myDF$newdates <- mdy(myDF$TRANSACTION_DT)

head(myDF)

#   newdates  
#   2019-07-11
#   2020-03-04
#   2019-12-18
#   2019-08-30
#   2019-03-21
#   2019-07-11

# Using tapply, add the values in the TRANSACTION_AMT column, 
# according to the values in the newdate column.

# tapply takes 3 inputs:
# the data to work on
# the way to break the date into groups
# the function to run on each piece of data


tapply(myDF$TRANSACTION_AMT, myDF$newdates, sum)
# the way Tapply work, you put the function at he end,
#i want to sum up the variables at the beginning,the TRANSACTION_AMT
# not all but broken into groups according to the newdates

myresults <- tapply(myDF$TRANSACTION_AMT, myDF$newdates, sum)

head(myresults)

#    2002-02-13 2010-08-08 2015-06-28 2015-06-29 2016-06-03 2016-06-04 2017-11-20 
#       500        500        250        275       1000        250        850...........................................


length(sort(unique(myDF$newdates)))
# i needed to sort this to put the dates in order as they would appear on the plot.
# on the x-axis, it has the unique dates listed in sorted order.
# on the y-axis , it has the corresponding values

# [1] 596

length(myresults)

[1] 596

plot(myresults)

plot(sort(unique(myDF$newdates)),myresults)
# This will alligned the right dollars with the right dates, on the right axes.



# Create a new dataframe that only contains data for the dates in the range 01/01/2019-05/15/2019

  class("01/01/2019")
# i need to convert this to date to be able to work with the term date not string

class(mdy("01/01/2019"))
# now converted to date

newDF <- subset(myDF, (newdates >= mdy("01/01/2019")) & (newdates <= mdy("05/15/2019")))

dim(myDF)

# [1] 495435     22

dim(newDF)

# [1] 495435     22


mynewresults <- tapply(newDF$TRANSACTION_AMT, newDF$newdates, sum)
head(mynewresults)

#  2019-01-01 2019-01-02 2019-01-03 2019-01-04 2019-01-05 2019-01-06 
#    286355     224173     343765     285968     130386     142742 

tail(mynewresults)
# 2019-05-10 2019-05-11 2019-05-12 2019-05-13 2019-05-14 2019-05-15 
#   1168083     282666     364190    1322745    1564637    1262397 

length(sort(unique(newDF$newdates)))
# to know how many days are in it.

# [1] 135

length(mynewresults)
# [1] 135

plot(sort(unique(newDF$newdates)),mynewresults)

# What do you notice about the data?

# From the plot there was steady increase from January, it also shows that more giving occours on different days of the week, certain days has more donations than the other.



# sum of the total donations contributed in each state.

# tapply takes 3 inputs:
# the data to work on
# the way to break the date into groups
# the function to run on each piece of data

v <- tapply(myDF$TRANSACTION_AMT, myDF$STATE, sum)

head(v)

#             AA      AB      AE      AK      AL 
#  431548   32243    1474   87137 1627993 7195054 

tail(v)

#    WA       WI       WV       WY       YT       ZZ 
#  19736146  5911445  1181879  3554048      162   823468 

length(v)

# [1] 78

sort(v)


head(myDF$CITY)

# [1] "CAPE CORAL"   "SCOTTSVILLE"  "HARTSDALE"    "WASHINGTON"   "GRAND RAPIDS"
# [6] "KISSIMMEE"

head(myDF$STATE)

# [1] "FL" "NY" "NY" "DC" "MI" "FL"

paste(head(myDF$CITY), head(myDF$STATE), sep= ", ")

# [1] "CAPE CORAL, FL"   "SCOTTSVILLE, NY"  "HARTSDALE, NY"    "WASHINGTON, DC"  
# [5] "GRAND RAPIDS, MI" "KISSIMMEE, FL"  

# Create a new column that pastes together the city and state. 

# [1] "CAPE CORAL, FL"   "SCOTTSVILLE, NY"  "HARTSDALE, NY"    "WASHINGTON, DC"  
# [5] "GRAND RAPIDS, MI" "KISSIMMEE, FL"   


 myDF$citystatepair  <-paste(myDF$CITY, myDF$STATE, sep= ", ")

head(myDF)

w <- tapply(myDF$TRANSACTION_AMT, myDF$citystatepair, sum)
# Find the total donation amount for each city/state location. 
head(w)

                 # B, CA              $0.00, PA             $20.00, PA 
                #   200                    122                     40 
              #  $49.02, PA             $72.53, PA 'CRESCENT CITY' CA, CA 
                #    98                    145                     81 

head(w, n=50)

# for the first 50

head(w, n=20)
# In the output do you notice anything suspicious in the result? From the fisrt 20, there are some missing data.


head(sort(w, decreasing=TRUE))
tail(sort(w, decreasing=TRUE), n=20)

# after sorting, looking at the tail some are negative.
# How do you think that occured?  It was due to omission and some have some money to be return to them


head(myDF$NAME)
class(myDF$NAME)

# Find the type of data that is in the NAME columm.    
# [1] "character"

grepl(", DON", head(myDF$NAME, n=50))
sum(grepl(", DON", head(myDF$NAME, n=50)))
# [1] 2
# only two with DON in their names in total of 50 names

sum(grepl(", DON", head(myDF$NAME, n=1000)))
# [1] 7
# only seven with DON in their names in total of 1000 names

Split up the names in the NAME column, to extract the first names of the donors. (This will not be perfect, but it is our first attempt.)


sum(grepl(", MARY", myDF$NAME))
# taking the head off and searching the entire column
# [1] 57516

sum(grepl(", MARY ", myDF$NAME))
# you can play around by putting space after the name mary but the values will change, it depends on how you want to do it.
# [1] 18031

length(myDF$TRANSACTION_AMT[grepl(", MARY ", myDF$NAME)])
# to compare withvalue gotten before.
# [1] 18031


# How much money is donated (altogether) by people named Mary? 
sum(myDF$TRANSACTION_AMT[grepl(", MARY ", myDF$NAME)])
# it means if i search for ", MARY " for which is TRUE, i will go and extract the TRANSACTION_AMT
# [1] 4007115


head(myDF)

head(myDF$EMPLOYER)
# [1] "RETIRED"      "NOT EMPLOYED" "NOT EMPLOYED" "SELF"         ""            
# [6] "HOMEMAKER"

head(myDF$EMPLOYER, n= 50)

sum(myDF$TRANSACTION_AMT[myDF$EMPLOYER =="NOT EMPLOYED"])
# [1] NA

sum(myDF$TRANSACTION_AMT[myDF$EMPLOYER =="NOT EMPLOYED"], na.rm=TRUE)
# to remove NA
# [1] 79250204

sum(myDF$TRANSACTION_AMT[myDF$EMPLOYER =="EMPLOYED"], na.rm=TRUE)
# only those that wrote down that they are employed.
# [1] 12418

sum(myDF$TRANSACTION_AMT[myDF$EMPLOYER !="NOT EMPLOYED"], na.rm=TRUE)
# this value removed only those that are not employed and leave the rest of the people
# it is not perfect.
# [1] 988014293

notemployed <-sum(myDF$TRANSACTION_AMT[myDF$EMPLOYER =="NOT EMPLOYED"], na.rm=TRUE)

employed <-sum(myDF$TRANSACTION_AMT[myDF$EMPLOYER !="NOT EMPLOYED"], na.rm=TRUE)

# Using a barplot or dotchart, show the total amount of donations made by EMPLOYED vs NOT EMPLOYED individuals

v <- c(notemployed, employed )

names(v) <- c("NOT EMPLOYED", "EMPLOYED")

barplot(v)


head(tapply(myDF$TRANSACTION_AMT, myDF$OCCUPATION, sum))

tail(tapply(myDF$TRANSACTION_AMT, myDF$OCCUPATION, sum))

head(sort(tapply(myDF$TRANSACTION_AMT, myDF$OCCUPATION, sum), decreasing=TRUE))

#   FOUNDER      RETIRED NOT EMPLOYED                  ATTORNEY          CEO 
#    279442327     98774206     84855951     77364020     31326953     25055647 

What is the category of occupation that donates the most money?  

# FOUNDER with  279442327


#  Plot something that you find interesting about the employment and/or occupation columns.

head(myDF$OCCUPATION)

 head(myDF$OCCUPATION, n=100)

sum(myDF$TRANSACTION_AMT[myDF$OCCUPATION =="ACCOUNTANT"])
# [1] NA


sum(myDF$TRANSACTION_AMT[myDF$OCCUPATION =="ACCOUNTANT"], na.rm=TRUE)

#  [1] 1067554

sum(myDF$TRANSACTION_AMT[myDF$OCCUPATION =="PROFESSOR"], na.rm=TRUE)

# [1] 4808341


accountant <-sum(myDF$TRANSACTION_AMT[myDF$OCCUPATION =="ACCOUNTANT"], na.rm=TRUE)

professor <-sum(myDF$TRANSACTION_AMT[myDF$OCCUPATION =="PROFESSOR"], na.rm=TRUE)

z <- c(accountant, professor )

names(z) <- c("ACCOUNTANT", "PROFESSOR")

barplot(z)

    # I used bar plot to show the total amount of donations made by ACCOUNTANT vs PROFESSOR
