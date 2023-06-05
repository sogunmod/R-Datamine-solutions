options(jupyter.rich_display = F)
options(repr.matrix.max.cols=50, repr.matrix.max.rows=200)
myeventDF <-read.csv("/anvil/projects/tdm/data/olympics/athlete_events.csv")
head(myeventDF)
table(myeventDF$Games)
# the years included in the data frame.
# What are the years included in this data.frame?
# when you run the table this diplay the years and the observation was majorly an increament of four years with alternate of summer and winter every four years.


length(table(myeventDF$Games))
# What are the different countries participating in the Olympics?
# it will give a total of 51.

head(sort(table(myeventDF$Team), decreasing = TRUE))
head(sort(table(myeventDF$Team), decreasing = TRUE), n=20)

# What are the different countries participating in the Olympics? 
# head(sort(table(myDF$Team), decreasing = TRUE)),
# The country are in the column call Team, and you make a table it will display all of them. when i sort using decreasing order and finding the head it bdisplayed he first six country.
# More so, finding the n=20, display the first 20 country.

length(table(myeventDF$Team))
# How many times is each country represented? There is 1184 different countries represented there.


mean(myeventDF$Height, na.rm=TRUE)
tapply(myeventDF$Height, myeventDF$Team, mean,na.rm=TRUE  )
# some might have NaN because the NA have been remove, they will be with no values.
head(sort(tapply(myeventDF$Height, myeventDF$Team, mean,na.rm=TRUE), decreasing = TRUE))
head(sort(tapply(myeventDF$Height, myeventDF$Team, mean,na.rm=TRUE), decreasing = TRUE), n=50)

# What is the average height of participants from each country? 
# consindering the first 50 countries you find the average heights from each countries using, head(sort(tapply(myDF$Height, myDF$Team, mean,na.rm=TRUE), decreasing = TRUE), n = 50)


max(myeventDF$Age)
max(myeventDF$Age, na.rm=TRUE)
head(sort(tapply(myeventDF$Age, myeventDF$Team, max,na.rm=TRUE), decreasing =TRUE), n=20)

# What are the oldest ages of the athletes from each country? 
# head(sort(tapply(myDF$Age, myDF$Team, max,na.rm=TRUE), decreasing =TRUE),n=20) for the first 20 countries

#      United States Great Britain        Canada        France       Germany 
#           97            84            81            81            80 
#        Austria       Belgium   Netherlands       Denmark        Latvia 
#           76            74            74            73            72 
#  n      Sweden    Crabe II-1   Crabe II-12    Crabe II-4         Italy 
#           72            71            71            71            71 
#         Japan  Pirouette-31   Pirouette-5        Poland       Uruguay 
#           71            71            71            71            71 

sum(myeventDF$Weight)
sum(myeventDF$Weight, na.rm=TRUE)
tapply(myeventDF$Weight, myeventDF$Team, sum,na.rm=TRUE  )
head(sort(tapply(myeventDF$Weight, myDF$Team, sum,na.rm=TRUE), decreasing = TRUE),n=50)

# What is the sum of the weights of all participants from each country? 
# head(sort(tapply(myDF$Weight, myDF$Team, sum,na.rm=TRUE), decreasing = TRUE),n=50), 
# this display the total weight of all participants from each country.

#  United States         France         Canada  Great Britain          Italy 
#      998567.3       545660.5       541615.5       533545.0       527239.0 
#       Germany      Australia          Japan         Poland         Sweden 
#      506186.0       471909.0       464511.0       403603.0       385579.5 
#      ........     ...........     ..........      .........      ........    
#      ........     ...........     ..........      .........      ........



options(jupyter.rich_display = F)
options(repr.matrix.max.cols=50, repr.matrix.max.rows=200)
myDF <- read.csv("/anvil/projects/tdm/data/death_records/DeathRecords.csv")
head(myDF)
str(myDF)

# What are the column names in this dataframe? 
# many are integers, while some are strings and character.

head(myDF$DayOfWeekOfDeath)
head(myDF$DayOfWeekOfDeath, n = 100)
table(head(myDF$DayOfWeekOfDeath, n = 100))

table(myDF$DayOfWeekOfDeath)
# each of the values from 1 to 7 come up with 37.... and 9 unknown came up with 128 value.

c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Unknown")
# each of these will be turn into character string
# to concatenate values together into vector, we use letter c

table(factor (myDF$DayOfWeekOfDeath,levels= c(1:7,9), labels=c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Unknown")))

myDF$mydays <- factor (myDF$DayOfWeekOfDeath,levels= c(1:7,9), labels=c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Unknown"))

# Change the column "DayOfWeekOfDeath" from numbers to weekdays

# myDF$mydays <- factor (myDF$DayOfWeekOfDeath,levels= c(1:7,9), labels=c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Unknown"))

table(myDF$mydays)
# this is same as table(myDF$DayOfWeekOfDeath)  , only that it has not been concanated yet to character and string.

# How many people died in total on each day of the week?

#  Sunday    Monday   Tuesday Wednesday  Thursday    Friday  Saturday   Unknown 
#   372388    375854    372792    380526    372464    378949    378070       128 


mean(myDF$Age)
tapply(myDF$Age, myDF$Sex, mean

# What is the average age of Females versus Males at death?         
#     F        M 
#  76.67668  70.22786 
       
table(myDF$MaritalStatus[ myDF$Sex == "F"])
# for the female only
       
table(myDF$MaritalStatus[ myDF$Sex == "M"])
# for the male only

#  What is the number of Females who are married? Divorced? Widowed? Single? 
#    D      M      S      U      W 
# 187807 324347 126868   5465 655223
# Now find the analogous numbers for Males.
#      D      M      S      U      W 
#    213152 655669 206175  13248 243217 
       
tapply(myDF$MaritalStatus, myDF$Sex, table) 
       
# Now solve both questions from 4b at one time, i.e., use one command to find the number of Females who are married, divorced, widowed, or single, and the number of Males in each of these four categories. You can compute all eight numbers with just one tapply command.
 
# $F

#     D      M      S      U      W 
#   187807 324347 126868   5465 655223 

# $M

#     D      M      S      U      W 
#   213152 655669 206175  13248 243217 

head(myDF)
sum(myeventDF$Weight, na.rm=TRUE)
myresult<-tapply(myeventDF$Weight,myeventDF$Team, sum,na.rm=TRUE)
dotchart(head(myresult))

dotchart(head(sort(tapply(myeventDF$Age, myeventDF$Team, max,na.rm=TRUE), decreasing =TRUE), n=20)
# plot for the oldest ages of the athletes from 20 countries.
       
       
dotchart(head(tapply(myDF$Age, myDF$Sex, mean)))
         
# plot for the average age of Females versus Males at death
         
dotchart(head(tapply(myDF$MaritalStatus, myDF$Sex, table))$F) 
         
# plot for the number of Females who are married, Divorced, Widowed and Single.
         
dotchart(head(tapply(myDF$MaritalStatus, myDF$Sex, table))$M)
         
# plot for the number of males who are married, Divorced, Widowed and Single.         

       
# Using the two data sets create two separate graphs or plots on the data that you find interesting (one graph or plot for each of the two data sets in this project). Write 1-2 sentences on each one and why you found it interesting/what you noticed in the dataset.

