tricy <- function (k) {
    # i can write other lines of R here
    k*k*k   # this is the value returned by the function at the end 
}
tricy(20)
# 8000

library(data.table)
titles <- data.frame(fread("/anvil/projects/tdm/data/movies_and_tv/titles.csv"))
episodes <- data.frame(fread("/anvil/projects/tdm/data/movies_and_tv/episodes.csv"))
people <- data.frame(fread("/anvil/projects/tdm/data/movies_and_tv/people.csv"))
ratings <- data.frame(fread("/anvil/projects/tdm/data/movies_and_tv/ratings.csv"))
head(titles)
table(titles$type)
titlesub <- subset(titles, (titles$type=="tvMovie") | (titles$type =="videoGame"))
dim(titlesub)
head(titlesub)
table(titlesub$type) 
formms <- table(titlesub$ type, titlesub$genres) 
barplot(formms, main="movies titles by type and genres",
        xlab= "numbers of types", col= c("darkblue","red"),
        legend = rownames(formms), beside=TRUE)

head(sort(table(titles$genres), decreasing=TRUE))
titlesuper <- subset(titlesub, (titlesub$genres=="Action") | (titlesub$genres =="Sport"))
dim(titlesuper)
table(titlesuper$genres)
dormms <- table(titlesuper$ type, titlesuper$genres) 
barplot(dormms, main="movies titles by type and genres",
        xlab= "numbers of types", col= c("darkblue","red"),
        legend = rownames(dormms), beside=TRUE)


head(titles)
x<- titles$premiered
y<- titles$	runtime_minutes
plot(x, y, type = "b", 
     col = "red", xlab = "x", ylab = "y")

plot(x, y, type = "s", 
     col = "red", xlab = "x", ylab = "y")

# What information are you gaining from either of these graphs?

# In the bar plot the values determine the heights of the bars, also known as side by side bar plot or clustered bar chart. While the line plot is,
# you will have the cordinate vectors of points to join, and different types of plotting to allow/to choose from.


find_movie_with_at_least_rating <- function(titles_df, ratings_df, ratings_of_at_least) {
    results <- merge(ratings_df, titles_df, by.x = "title_id", by.y = "title_id")
    popular_movie_results <- results[results$type == "movie" & results$rating >= ratings_of_at_least, ]
    return(popular_movie_results)
}

newDF <- find_movie_with_at_least_rating(titles, ratings, 9)
# outside the function you can pass in anything you like.  

dim(titles)

dim (ratings)

dim (newDF)

head (newDF)


find_movie_with_at_least_rating <- function(titles_df, ratings_df, ratings_of_at_least) {
    # the function contain the different data frame for titles, ratings as i have them above in question 1 folder and the least rating
     results <- merge(ratings_df, titles_df, by.x = "title_id", by.y = "title_id")
    # create another folder for merging
    # use the command for merging to create merging folder
    popular_movie_results <- results[results$type == "movie" & results$rating >= ratings_of_at_least, ]
    # after merging you run in the result folder, for type and ratings and the least in consideration
    return(popular_movie_results)
    # it will return the popular movie result
}


find_movie_with_at_least_rating <- function(titles_df, ratings_df, ratings_of_at_least) {
    results <- merge(ratings_df, titles_df, by.x = "title_id", by.y = "title_id")
    popular_movie_results <- results[results$type == "movie" & results$rating >= ratings_of_at_least, ]
    return(popular_movie_results)
}

my_selection <- find_movie_with_at_least_rating(titles, ratings, 7.6)
dim(my_selection)
head(my_selection)



find_movie_with_at_most_rating <- function(titles_df, ratings_df, ratings_of_at_most) {
    results <- merge(ratings_df, titles_df, by.x = "title_id", by.y = "title_id")
    popular_movie_results <- results[results$type == "movie" & results$rating <= ratings_of_at_most, ]
    return(popular_movie_results)
}

my_view <- find_movie_with_at_most_rating(titles, ratings, 6.0)

dim(my_view)

head(my_view)


find_movie_with_at_most_rating <- function(titles_df, ratings_df, ratings_of_at_most) {
    results <- merge(ratings_df, titles_df, by.x = "title_id", by.y = "title_id")
    popular_movie_results <- results[results$type == "movie" & results$rating < ratings_of_at_most, ]
    return(popular_movie_results)
}

my_consent <- find_movie_with_at_most_rating(titles, ratings, 6.0)

dim(my_consent)

head(my_consent)


# How many movies in total are there, which are above that limit? 34340.11

# Change the limits in the function from "at least 6.0" to "lower than 6.0". 114707.11

# How many movies have ratings lower than 6.0? 106471.11


my_most_popular_movie <- # send the titles data frame, ratings data frame, and the name of the genres
                        #  merge the data frames, just like we did above
                        #  make a similar data frame, only contain movies which are only from the genre you picked
                        # make an even smaller data frame, with rows that have the property myDF$rating = max(myDF$rating)
                        # return that even smaller data frame

my_best_movie <- function(titles_df, ratings_df, genre) {
    results <- merge(ratings_df, titles_df, by.x = "title_id", by.y = "title_id")
    my_genres_output <- results[results$type == "movie" & results$genres == genre, ]
    famous <-  my_genres_output[ my_genres_output$rating== max( my_genres_output$rating), ]
     return(famous)
}  
                     

results <- merge(ratings, titles, by.x = "title_id", by.y = "title_id")
dim(results)
genre<- "Thriller"

my_genres_output <- results[results$type == "movie" & results$genres == genre, ]

famous <-  my_genres_output[ my_genres_output$rating== max( my_genres_output$rating), ]

thrillerDF<-my_best_movie(titles,ratings,"Thriller")
dim(thrillerDF)

dim(my_genres_output)
dim(famous)

thrillerDF<-my_best_movie(titles,ratings,"Romance")
dim(thrillerDF)
thrillerDF

thrillerDF<-my_best_movie(titles,ratings,"Action")
dim(thrillerDF)
thrillerDF

head(results)
my_best_movie_by_vote <- function(titles_df, ratings_df, genre) {
    results <- merge(ratings_df, titles_df, by.x = "title_id", by.y = "title_id")
    my_genres_output <- results[results$type == "movie" & results$genres == genre, ]
    # to look for best movie by vote, you will replace votes for rating
    famous <-  my_genres_output[ my_genres_output$votes== max( my_genres_output$votes), ]
     return(famous)
} 

thrillerDF<-my_best_movie_by_vote(titles,ratings,"Action")
thrillerDF

thrillerDF<-my_best_movie_by_vote(titles,ratings,"Romance")
thrillerDF
 
