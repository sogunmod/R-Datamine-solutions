unique(myDF$region)

# How many unique regions are there in total? 403

head(myDF$region)

# different regions that are included in this dataset are:mohave county, oregon coast, greenville/upstate, mohave county, maine.

sum(myDF$year >=2011, na.rm=TRUE)

# How many cars are manufactured in 2011 or afterwards, i.e., they are made in 2011 or newer? 257000

head(table(myDF$year))
head(myDF$year[order(myDF$year)])    
# another way to approach the year oldest model cars was manufactured

# In what year was the oldest model manufactured? 1900

tail(table(myDF$year))
tail(v[order(v)])
# another way to approach the year recent model cars was manufactured

# In what year was the most recent model manufactured? 2021

head(sort(table(myDF$year), decreasing=TRUE))
# just six out of the whole table

In which year were the most cars manufactured? In 2017 there were 34592 cars represented in this data.

myDF$newflag <- NA
myDF$newflag[myDF$condition =="like new"] <-TRUE
myDF$newflag[myDF$condition !="like new"] <-FALSE
table(myDF$newflag)

# 27604 times i found like new in the data column to make the newflag to be true and 408245 times of false in the new column.

myDF$pricecategory <- NA
myDF$pricecategory[myDF$price <= 1500] <- "cheap"
myDF$pricecategory[(myDF$price > 1500) & (myDF$price <= 10000)] <- "average"
myDF$pricecategory[myDF$price > 10000] <- "expensive"
table(myDF$pricecategory) 


# cheap for vehicles less than or equal to $1,500 has 48431 cars

# average for vehicles strictly more than $1,500 but less than or equal to $10,000 has 175158 cars

# expensive for vehicles strictly more than $10,000 has 212260 cars


table(myDF$newflag, useNA="always")
# Just to double check if there is any NA.

# 27604 vehicles are like new and 408245 are not like new.

head(cut(myDF$odometer, breaks=c(-Inf,50000,100000, Inf)))

head(cut(myDF$odometer, breaks=c(-Inf,50000,100000, Inf),labels=c("new","middle age","old")))

# Using the cut function and appropriate breaks, new column called newpricecategory is identical to the previously created pricecategory column, created in question TWO.

myDF$odometerage <-cut(myDF$odometer, breaks=c(-Inf,50000,100000, Inf),labels=c("new","middle age","old"))

# Another column called odometerage, which has values new or middle age or old, according to whether the odometer is (respectively): less than or equal to 50000; strictly greater than 50000 and less than or equal to 100000; or strictly greater than 100000. How many cars are in each of these categories?

myIndy <- subset(myDF, region=="indianapolis") 
dim(myIndy)

# Extract all of the data for indianapolis into a data.frame called myIndy.   [1] 2967   29

head(sort(table(myDF$region), decreasing=TRUE))

# Identify the most popular region from myDF = springfield  

popularregion <- subset(myDF, region=="springfield")
dim(popularregion)

# and extract all of the data from that region into a data.frame called popularRegion.  [1] 3595   29

creativeregion <- subset(myDF, region=="richmond")
dim(creativeregion)

# Create a third data.frame with the data from a region of your choice. creative region richmond with [1] 3046   29 data in it.

options(jupyter.rich_display =T )
# to be able to remove error and have map shown, you need to turn your rich to T.

points <- st_as_sf(myIndy,coords=c("long","lat"), crs= 4326)

addCircleMarkers(addTiles(leaflet(myIndy)),radius=1)

# the maps are on the templates



addCircleMarkers(addTiles(leaflet(popularregion)),radius=1)

addCircleMarkers(addTiles(leaflet(creativeregion)),radius=1)


# I used library(leaflet)  library( sf) to generate my map
