options(jupyter.rich_display = F)
options(repr.matrix.max.cols=50, repr.matrix.max.rows=200)
library(data.table)
titles <- data.frame(fread("/anvil/projects/tdm/data/movies_and_tv/titles.csv"))
episodes <- data.frame(fread("/anvil/projects/tdm/data/movies_and_tv/episodes.csv"))
people <- data.frame(fread("/anvil/projects/tdm/data/movies_and_tv/people.csv"))
ratings <- data.frame(fread("/anvil/projects/tdm/data/movies_and_tv/ratings.csv"))
head (titles)

titles [titles$ title_id == "tt0108778", ]
# to find out the row in the title table that corressponds to the whole friends show,look up the title df 
# and find out the role of the title id is (equalto the one for friends), we get the row and all the columns

head (episodes )

head (people)

head (ratings)

head(titles$genres)
# the first six category of artistic composition

head(titles$genres, n=50)
# the first 50 of them

length(titles$genres)
# there total together with repitition

length(unique(titles$genres))
# the unique title of the category of artistic composition

head(unique(titles$genres))
# No repitition of titles of the first six category of artistic composition

head(unique(titles$genres), n=50)
# first 50 no repitition like the previous

head(strsplit(unique(titles$genres), ","))
# then you can do string split
# split these unique occurrences of the genres column in the titles table
# split according to a comma
# then the first six

class(strsplit(unique(titles$genres), ","))

head(unlist(strsplit(unique(titles$genres), ",")))

head(unlist(strsplit(unique(titles$genres), ",")), n=50)


unique(unlist(strsplit(unique(titles$genres), ",")))
# to check for the unique listed genres in the titles table after unlisted.

#  What are all the different listed genres (in the titles table)? 
#  There are 29 of them, though one appears to be erroneous among them.

#  [1] "Documentary" "Short"       "Animation"   "Comedy"      "Romance"    
#  [6] "Sport"       "News"        "Drama"       "Fantasy"     "Horror"     
# [11] "Biography"   "Music"       "War"         "Crime"       "Western"    
# [16] "Family"      "Adventure"   "Action"      "History"     "Mystery"    
# [21] "\\N"         "Sci-Fi"      "Musical"     "Thriller"    "Film-Noir"  
# [26] "Talk-Show"   "Game-Show"   "Reality-TV"  "Adult" 


head(titles$genres)

grepl("Comedy",head(titles$genres))
# allow us to extract just the rows in which comedy appear.

head(titles[grepl("Comedy", titles$genres), ])

head(titles[grepl("Comedy", titles$genres), ]$premiered)
# this display their years of premiered

table(titles[grepl("Comedy", titles$genres), ]$premiered)

sort(table(titles[grepl("Comedy", titles$genres), ]$premiered), decreasing = TRUE)

# Look at the years column and the genres column. In which year did the most comedies debut?  year 2016

#  2016  2017  2015  2018  2014  2013  2019  2012  2020  2011  2010  2009  2008 
# 84227 83916 80199 78393 77034 71963 70457 65305 61237 57892 48825 43095 39734 
 

outcomeDF <- merge(episodes, titles, by.x = "episode_title_id", by.y = "title_id")

head(outcomeDF)

dim(outcomeDF[outcomeDF$show_title_id == "tt0108778", ])

# Use the episode_title_id column and the title_id column from the episodes and titles data.frame’s (respectively) to merge the two data.frames.

# outcomeDF <- merge(episodes, titles, by.x = "episode_title_id", by.y = "title_id")

expectDF <- outcomeDF[outcomeDF$show_title_id == "tt0108778", ]
# daeling with only show called Friends

dim (expectDF)

head(expectDF)
# no title of Friends anywhere.

head(merge(expectDF, titles, by.x = "show_title_id", by.y = "title_id"))
# it shows the title_id and Primary titles, Friends

deepDF <- merge(expectDF, titles, by.x = "show_title_id", by.y = "title_id")

head(merge(deepDF, ratings, by.x = "episode_title_id", by.y = "title_id"))

newDF <- merge(deepDF, ratings, by.x = "episode_title_id", by.y = "title_id")

head(merge(newDF, ratings, by.x = "show_title_id", by.y = "title_id"))
# this gave ratings of episodes and of friends together.

head(merge(newDF, ratings, by.x = "show_title_id", by.y = "title_id")[ ,c("primary_title.x", "primary_title.y", "rating.x", "rating.y")])

friendsDF <- merge(newDF, ratings, by.x = "show_title_id", by.y = "title_id")[ ,c("primary_title.x", "primary_title.y", "rating.x", "rating.y")]

dim(friendsDF)

head(friendsDF)

names(friendsDF) <- c("episode_title", "show_title", "episode_rating", "show_rating")

head(friendsDF)

head(friendsDF$episode_rating)

order(friendsDF$episode_rating)
# this get the analogous rows in the order

tail(friendsDF[order(friendsDF$episode_rating), ], n=7)
# it gives all of the columns organized
# look for the tail and the , last 7
# these are the highest rated episodes of friends across all ten seasons of friends


# Show the top 5 rows of your final data.frame that contain the top 5 rated episodes.

# episode_title                     show_title episode_rating show_rating
# 209 The One with the Rumor            Friends    9.3            8.9        
# 225 The One with the Videotape        Friends    9.3            8.9        
# 235 The One with the Proposal         Friends    9.3            8.9        
# 202 The One with the Prom Video       Friends    9.4            8.9        
# 167 The One with the Embryos          Friends    9.5            8.9        
# 3   The Last One                      Friends    9.7            8.9        
# 21  The One Where Everybody Finds Out Friends    9.7            8.9 

outcomeDF <- merge(episodes, titles, by.x = "episode_title_id", by.y = "title_id")

expectDF <- outcomeDF[outcomeDF$show_title_id == "tt0108778", ]

deepDF <- merge(expectDF, titles, by.x = "show_title_id", by.y = "title_id")

newDF <- merge(deepDF, ratings, by.x = "episode_title_id", by.y = "title_id")

friendsDF <- merge(newDF, ratings, by.x = "show_title_id", by.y = "title_id")

friendsDF <- merge(newDF, ratings, by.x = "show_title_id", by.y = "title_id")[ ,c("primary_title.x", "primary_title.y", "rating.x", "rating.y", "season_number")]

names(friendsDF) <- c("episode_title", "show_title", "episode_rating", "show_rating", "season_number")

head(friendsDF)

friendsDF[ (friendsDF$episode_rating>9)& (friendsDF$season_number ==5), ]

subset( friendsDF, (episode_rating>9)& (season_number ==5))

# Use regular old indexing to find all episodes of friends with an episode_rating greater than 9 and season_number of exactly 5.

# Repeat the process, but this time use the subset function instead.


season_number = 6

friendsDF[friendsDF$episode_rating>9 & friendsDF$season_number ==season_number, ]

subset(friendsDF, episode_rating> 9 & season_number == season_number)

# Read that provided article and do your best to explain why subset gets a different result than our example that uses regular indexing.
# By defaults subset removes NA rows
# Subset is useful interactive shortcut for subsetting data frame, instead of repeating the names of dataframe many times, you save some typing.
# majorly it avoid repitition of output that are thesame.
