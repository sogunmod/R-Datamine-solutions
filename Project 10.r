options(jupyter.rich_display = F)
options(repr.matrix.max.cols=50, repr.matrix.max.rows=200)
library(data.table)

users<- fread("/anvil/projects/tdm/data/okcupid/filtered/users.csv")
# fread, though will determine automatically what the dome meter are in the file

questions <- fread("/anvil/projects/tdm/data/okcupid/filtered/questions.csv")
# fread, though will determine automatically what the dome meter are in the file

dim (users)

dim(questions)

head(users)
head(questions)

head(users$gender_orientation)
tail(users$gender_orientation)

head(users$race)
tail(users$race)

head(questions$Type)
tail(questions$Type)

head(questions$text)
tail(questions$text)
 
# Take a look at both data.frames and identify what is a part of each of them. 
#  user data frame has 68371 rows  2284 columns
#  questions data frame has 2281 rows 10 columns

# What information is in each datatset, and how they are related?

#  For the the user, it is a data set about human being in respect to their gender and what they are interested in.
#  for the question, it is a data set that has series of questions related to the user, in respect to texts, type, options, keywords as it applies.

?grep
# grep helps to look for pattern inside text
# to see help functions using grep
# to see other function the help using grep (in different ways to use grep)

dim(questions)
#   it has 10 columns

head(questions)
#  to see the word gooogle, it may be possible with text

grep("Google",questions$text)
# it does find it one time on row 2172

questions[2172, ]
# to detect the what is in the column

questions$text[grepl("Google",questions$text)]
# another way is using logical grep (grepl)
# a neat thing about grepl is use the location at the begining as a position within the vector of text within the text column


#  What do you notice if you just use the function grep() and create a new variable google and then print that variable?
#   it helps to locate the number of occurence and the row it appears.

#  Now that you know the row number, how can you take a look at the information there? by running (questions[2172, ])
#       X       text                                       option_1                
#   1 q170849 Do you Google someone before a first date? Yes. Knowledge is power!
#     option_2                   option_3 option_4 N     Type Order
#   1 No. Why spoil the mystery?                   39621 O         
#      Keywords               
#   1 descriptive; technology

#  using grepl
#  "Do you Google someone before a first date?"


dim(users)
# 68371rows  2284columns
# roughly one colmn per question

head(users)
# showing one column per question

which(names(users) == "q170849")
# to look for which one is TRUE
# out of the users  data frame, colmn 1193 is TRUE

users[ ,1193]
# to detect what is in the row

table(users[[1193]], useNA = "always")
# another way to look at it
# because the outcome contain NA's, 
# then use table and use NA to know how many NA are there

prop.table(table(users[[1193]], useNA = "always"))
# this shows the proportion

(prop.table(table(users[[1193]], useNA = "always")))*100
# to know the actual percentage by multiplying by 100

users[2172 ,1193]
# for verification

#  Using the row from our previous question, which variable does this correspond with in the data.frame users?
#  colmn 1193
# Row 2172 in questions corresponds to column named q170849 in users

# knowing that the two possible answers are "No. Why spoil the mystery?" and "Yes, Knowledge is power!" What percentage of users do NOT google someone before the first date? 37.74%

tapply(users[[1193]], gender, table)
# we want to break things up using the table 
# we are yet to look at the gender
# colomn to consider that is for gender is (gender 2 in column 2282)

head(users[[2282]])
# these are the genders there.
# the column named gender2 is 2282

tapply(users[[1193]], users[[2282]], table)
# we are going to take the data from how people responded to the Google questions
# break it up according to the gender
# within all the males responses, we take the data and make a table
# within all the females responses, we take the data and make a table

tapply(users[[1193]], users[[2282]], table,useNA = "always")
# put useNA = "always" to know the number of people that did not respond in each gender

tapply(users[[1193]], users[[2282]], function(x) {prop.table(table(x,useNA = "always"))})
# another way to calculate the percentage using prop.table

tapply(users[[1193]], users[[2282]], function(x) {(prop.table(table(x,useNA = "always")))*100})

sapply(tapply(users[[1193]], users[[2282]], table,useNA = "always"),prop.table)
# this apply prop.table to each
# this take data from men and make proportion to women


# sapply works like this:    sapply(mydata, myfunction)
# sapply takes some data and a function that you want to run on each piece of the data

head(users$gender_orientation)

head(users$gender_orientation, n=20)
