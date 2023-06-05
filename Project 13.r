file.info("/anvil/projects/tdm/data/beer/beers.csv")
# Here you can put the name of the file and get all kinds of information about the file

file.info("/anvil/projects/tdm/data/beer/beers.csv")$size
# to know the particular quantity of the size in the column

library(data.table)
drinks <- fread("/anvil/projects/tdm/data/beer/beers.csv")

dim(drinks)
# 358873 rows, 10 columns

# to look at type of data and information about the file
str(drinks)

head(drinks)

# then grep Stout in the style column
grep("Stout", head(drinks$style))
# the word stout in column 1,2 and 4

# then look at te scores of all those beers under abv and 
# pull out relevant numbers
drinks$abv[grep("Stout", head(drinks$style))]

mean(drinks$abv[grep("Stout", head(drinks$style))])
# then take the mean,average of the three scores
# since we have achieved for the fisrt six then take the head off and run the entire data set

mean(drinks$abv[grep("Stout", drinks$style)], na.rm=TRUE)
# this is the average score for all the beer.

grep("Pale Ale", head(drinks$style))

grep("Pale Ale", head(drinks$style, n=100))
# for the first 100

# to see what they are called
drinks$style[grep("Pale Ale", head(drinks$style, n=100))]

# how many are there?
length(grep("Pale Ale", head(drinks$style, n=100)))

# in the whole data set 
length(grep("Pale Ale", drinks$style))

grep("Pale", head(drinks$style))
grep("Pale", head(drinks$style, n=100))
drinks$style[grep("Pale", head(drinks$style, n=100))]
length(grep("Pale", head(drinks$style, n=100)))
length(grep("Pale", drinks$style))

grep("Ale", head(drinks$style))
grep("Ale", head(drinks$style, n=100))
drinks$style[grep("Ale", head(drinks$style, n=100))]
length(grep("Ale", head(drinks$style, n=100)))
length(grep("Ale", drinks$style))

grep("Stout", head(drinks$style))
grep("Stout", head(drinks$style, n=100))
drinks$style[grep("Stout", head(drinks$style, n=100))]
length(grep("Stout", head(drinks$style, n=100)))
length(grep("Stout", drinks$style))

# What is the file size, how many rows, columns and type of data? The file size is 43MB,358873 rows, 10 columns. Types are integer, character and number

# What is the average score for a stout? (consider a stout any named beer from the column name with the word stout in it). it is 8.2

# How many Pale Ale’s are on this list? (consider a stout any named beer from the column name with the word pale and ale in it)
#  for Pale Ale is 35689, for Pale is 45287, for Ale is 107413 and for Stout is 35943


options (jupyter.rich_display = F)
options(repr.matrix.max.cols=25, repr.matrix.max.rows=25)
head(drinks)
table(drinks$availability)
# check with availability column

length(table(drinks$name[drinks$availability == "Summer"]))
# to know beers available in summer only
# they are so much, so look for length

x <- tapply(drinks$abv[drinks$availability == "Summer"], 
      drinks$name[drinks$availability == "Summer"], mean, na.rm = TRUE)

# to first look at the score for them
# split them up according to their name
# then take an average

head(x)
length(x)
head(sort(x, decreasing =TRUE))
# most popular with the highest score

head(sort(x, decreasing =TRUE), n = 20)
# most top 20 according to their score

dotchart(head(sort(x, decreasing =TRUE), n = 20))

head(drinks)
y <- tapply(drinks$abv, drinks$country, mean, na.rm = TRUE)

# now break the data up according to the country
# then look up the scores for the whole data set
# means looking at the score, broken up into their mean

length(y)
head(sort(y, decreasing =TRUE))
head(sort(y, decreasing =TRUE), n = 20)
dotchart(head(sort(y, decreasing =TRUE), n = 20))
plot(head(sort(y, decreasing =TRUE), n = 20))

head(drinks$abv[drinks$availability == "Limited (brewed once)"])
# the first six scores for which the availability was limited brewed once


median(drinks$abv[drinks$availability == "Limited (brewed once)"])
# then take their median

median(drinks$abv[drinks$availability == "Limited (brewed once)"], na.rm=TRUE)

median(drinks$abv, na.rm=TRUE)
# median of the whole data set

table(drinks$availability)

unique(drinks$availability)

# Do limited runs of beer have a greater median rating than all others? (consider limited to be any beer that has the word Limited in the availablity column) # # Yes

# Use the unique function to investigate the availablity column. Why are there different labels that are technically the same?
# From the listed columns the one of rotating is more or less also what could possibly be available in any season of the year and also year round is available # all throught the year, but for pertinent reasons like Fall, Winter and Summer are only available for their specified season while the limited from the name # # is so limited.