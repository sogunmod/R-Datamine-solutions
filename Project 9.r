options(jupyter.rich_display = F)
options(repr.matrix.max.cols=50, repr.matrix.max.rows=200)
library(data.table)
itcont <- fread("/anvil/projects/tdm/data/election/escaped/itcont2020sample.txt")
head(itcont)

benford_law <- function (d) { log((d+1)/d)/ log(10) }
benford_law (1)
digits <- 1:9
digits

benford_law (2)
# this can be done but it bwill take lot of time

sapply(digits,benford_law )
sum(sapply(digits,benford_law ))
# the summation is 1 to prove probability summation

plot(sapply(digits,benford_law ))

barplot(sapply(digits,benford_law ))


head(itcont)
head(itcont$TRANSACTION_AMT)

substr(head(itcont$TRANSACTION_AMT), 1,1)
# using substring to go to first position and get the first digits of those numbers using 1,1

substr(head(itcont$TRANSACTION_AMT, n=50), 1,1)
#  this is for the first 50 number

table(substr(head(itcont$TRANSACTION_AMT, n=10000), 1,1))
# from the table there are -ve and zeros with values

table(substr(itcont$TRANSACTION_AMT, 1,1))
# this is the table of all the results 
# Then need to remove those of -ve and zeros
# to do that there are eleven element from -ve to 9 (1:11)

table(substr(itcont$TRANSACTION_AMT, 1,1)) [3:11]
#this is from 3:11 elements
# this show only the digits from 1:9

firstdigit <- table(substr(itcont$TRANSACTION_AMT, 1,1)) [3:11]
# create a vector called first digit

class(firstdigit)
#   [1] "table"

plot (firstdigit)

firstdigit

sapply(digits,benford_law )

firstdigit/sapply(digits,benford_law )


head(itcont)
head(itcont$EMPLOYER) 
head(itcont$OCCUPATION) 

k <- rep(TRUE,6)
# let k rep TRUEfor the first 6 for both employer and occupation

k

k[head(itcont$EMPLOYER) == "NOT EMPLOYED"] <- FALSE
#  FALSE column if employer is not employed

k[head(itcont$OCCUPATION) == "NOT EMPLOYED"] <- FALSE
#  FALSE column if occupation is not employed

k
# it false for the first value because occupation say not employed
# false second and third value because both says not employed
# false for forth, fifth and sixth value because it is notemployed for the three

itcont$employed <- TRUE
itcont$employed[itcont$EMPLOYER == "NOT EMPLOYED"]<- FALSE
itcont$employed[itcont$OCCUPATION == "NOT EMPLOYED"]<- FALSE
table(itcont$employed)

myemployerarray <- function (relaydf) {
    # since I called the function relaydf, i must change itcont to relaydf
    relaydf$employed <- TRUE
    relaydf$employed[itcont$EMPLOYER == "NOT EMPLOYED"]<- FALSE
    relaydf$employed[itcont$OCCUPATION == "NOT EMPLOYED"]<- FALSE
    return(relaydf)
}
 
head(myemployerarray(itcont))

table(myemployerarray(itcont)$employed)


myemployerarray <- function (relaydf) {
    # it has one argument
    relaydf$employed <- TRUE
    # create a data frame that has all EMPLOYER employed to be true
    relaydf$employed[itcont$EMPLOYER == "NOT EMPLOYED"]<- FALSE
    # a data frame for EMPLOYER when it is not employed to reflect false
    relaydf$employed[itcont$OCCUPATION == "NOT EMPLOYED"]<- FALSE
     # a data frame for OCCUPATION when it is not employed to reflect false
    return(relaydf)
    #return (the number of TRUE from FALSE in the argument data frame)
}

myemployerarray <- function (relaydf) {
    relaydf$employed <- TRUE
    relaydf$employed[itcont$EMPLOYER == "NOT EMPLOYED"]<- FALSE
    relaydf$employed[itcont$OCCUPATION == "NOT EMPLOYED"]<- FALSE
    return(relaydf)
}


table(myemployerarray(itcont)$employed)

dotchart(table(myemployerarray(itcont)$employed))

plot(table(myemployerarray(itcont)$employed))



gotcha<-table(itcont$employed)
# to show the percentage of individuals employed vs not employed

gotcha/2
# divididing the equation by 2
# sample for verification

(gotcha/sum(gotcha))*100
# individual ( TRUE, FALSE) divided by their summation
# multiply the answer by 100 to change to percentage


barplot((gotcha/sum(gotcha))*100)
# barplot graph

percentage <-((gotcha/sum(gotcha))*100)
# create  data frame for the division oucome

barplot(percentage, main="percentage of individuals employed vs not employed",
        xlab= "employment status", col= c("darkblue","red"),
       ylab = "percentage")

# to put label and clour


head(itcont)


temp <- function(state, max_amount) {
     yope<-itcont[itcont$STATE==state]
    rope<- yope[yope$TRANSACTION_AMT <= max_amount]
    return (rope)
    
    
}

state<- "FL"

yope<-itcont[itcont$STATE==state]

head(yope)
# a subset of itcont  inside one state

rope<- yope[yope$TRANSACTION_AMT <= 15]

head(rope)