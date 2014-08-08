## from:
##http://blog.revolutionanalytics.com/2014/06/reading-data-from-the-new-version-of-google-spreadsheets.html

## could not get the approach using the functions in "functions.R" to work.
## So, I use the appraoch
## from the comments, used the "KEY" trick to force a csv download

require(RCurl)
KEY <- "1laWhxQ7ugFs1b3nyhDdjp8-DAN9ZK0J3Zn86cM0BhH8"
url <- paste(
    "https://docs.google.com/spreadsheets/d/",KEY,"/export?format=csv&id=",KEY,
    sep="")
myCsv <- getURL(url,.opts=list(ssl.verifypeer=FALSE))
test <- read.csv(textConnection(myCsv))
head(test)
test[1:10,1:5]
commute<-as.data.frame(test[test$destination %in% c("Baltimore","NIH"),])
##commute[commute==""] <- NA
commute$destination<-factor(commute$destination, levels=rev(c("Baltimore","NIH")))
summary(commute$destination)

require(ggplot2)
ggplot(data=commute, aes(x=mpg,   y=duration))+geom_point()+facet_grid(.~destination)
ggplot(data=commute, aes(x=mpg,   y=duration, color=destination))+geom_point(alpha=.5)
ggplot(data=commute, aes(x=start, y=duration, size=mpg))+geom_point()+facet_grid(.~destination)
ggplot(data=commute, aes(x=day, y=duration, size=mpg))+geom_point(alpha=.5,position = position_jitter(w = 0.1, h = 0))+facet_grid(.~destination)+scale_size_continuous(range = c(3,10))
##ggplot(data=commute, aes(x=day, y=mpg, size=duration))+geom_point()+facet_grid(.~destination)

## need to weed out some routes...
ggplot(data=commute, aes(x=mpg, y=duration))+geom_point()+facet_grid(destination~route)
