myDF <- read.csv("/anvil/projects/tdm/data/flights/subset/1995.csv", stringsAsFactors = TRUE)

dim(myDF)

# A. It has 29 column
# B. It has 5327435 rows

str(myDF)

# C. The type of data in the data frame are integer, factor and logical

myairports <- myDF$Origin

str(myairports <- myDF$Origin)

# a. The type of data in the vector myairports is Factor with 218 levels.

table(head(myDF$Origin,n=250))

table(head(myDF$Origin,n=250))["ORD"]

# b. How many of the first 250 flights departed from O’Hare? 237. To get this you can use either the code with "ORD" or without.

table(myDF$Origin)

sort(table(myDF$Origin))

tail(sort(table(myDF$Origin)))

sort(table(myDF$Origin),decreasing=TRUE)

head(sort(table(myDF$Origin),decreasing=TRUE))

# c. How many flights departed by O’Hare altogether in 1995? 293422.  To get this you can use either of the last five code.

table(myDF$Origin)

sort(table(myDF$Origin))

table(myDF$Origin)["IND"]

# How many flights departed from Indianapolis (IND) in 1995? 37092

table(myDF$Dest)

sort(table(myDF$Dest))

table(myDF$Dest)["IND"]

#How many flights landed there? 37103

head(myDF$Origin,row=894)

head(myDF,row=894)

# Consider the flight data from row 894 the data frame. What airport did it depart from? ORD

head(myDF$Dest,row=894)

head(myDF,row=894)

# Where did it arrive? PHL

length(myDF$Dist[myDF$Dist <200])
# this method includes the NA values ( it keeps the NA values around, incase you want them)
# 475141

# How many flights have a distance of less than 200 miles? 475141

head(myDF$Dist < 200)
# [1] FALSE FALSE FALSE FALSE FALSE FALSE

head(myDF$Dist >= 200)
# [1] TRUE TRUE TRUE TRUE TRUE TRUE

sum(myDF$Dist < 200)
# when i tried adding TRUEand FALSE values
# the TRUE values become 1
# the FALSE value become 0
# so the sum is the number of true values

# NA

sum(myDF$Dist < 200, na.rm=TRUE)

# when i tried adding TRUEand FALSE values
# the TRUE values become 1
# the FALSE value become 0
# so the sum is the number of true values

# 469154

sum(myDF$Dist < 200, na.rm=TRUE)

# 469154

sum(myDF$Dist >= 200, na.rm=TRUE)

# 4852294

sum(is.na(myDF$Dist))

# 5987

469154 + 4852294 + 5987

# 5327435

sort(table(myDF$UniqueCarrier))

# Rank the airline companies

#  AS     HP     TW     CO     NW     AA     WN     UA     US     DL 
# 135124 194508 272452 434425 521693 688471 693101 724807 778835 884019 


sort(table(myDF$UniqueCarrier), decreasing=TRUE)

# DL     US     UA     WN     AA     NW     CO     TW     HP     AS 
# 884019 778835 724807 693101 688471 521693 434425 272452 194508 135124 

head(sort(table(myDF$UniqueCarrier), decreasing=TRUE), n=3)

# Which are the three most popular airlines from 1995? 

# DL     US     UA 
# 884019 778835 724807 


head(sort(table(myDF$TailNum),decreasing=TRUE), n=50)


# Now find the ten airplanes that had the most flights in 1995. List them in order, from most popular to least popular. Do you notice anything unusual about the results?

# N67    N89    N83    N71   N103    N68   N102    N91    N59    N64 
# 3485   3479   3476   3474   3463   3458   3448   3448   3447   3434 their differences or variation from each other is pretty minimal.

head(sort(table(myDF$Origin),decreasing=TRUE),n=25)

# ORD    DFW    ATL    LAX    STL    PHX    DTW    MSP    CLT    DEN    SFO 
# 293422 268127 230470 179909 174847 157155 147610 136436 131417 130327 129137 
# PIT    IAH    LAS    EWR    LGA    BOS    SEA    PHL    DCA    SLC    CVG 
# 126190 121029 112181 109592  99225  92852  92016  91577  86266  84056  76629 
# MIA    MCO    CLE 
# 70581  67900  66888 

plot(head(sort(table(myDF$Origin),decreasing=TRUE),n=25))


dotchart(head(sort(table(myDF$Origin),decreasing=TRUE),n=25))


dotchart( rev(head(sort(table(myDF$Origin),decreasing=TRUE),n=25) ))

# Descibe any patterns you may see in the plot and the dotchart. It has a snake like shape.
