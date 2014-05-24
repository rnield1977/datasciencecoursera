library(XML)
#theurl <- "http://en.wikipedia.org/wiki/Brazil_national_football_team"
doc.html = htmlTreeParse('http://biostat.jhsph.edu/~jleek/contact.html',
                         useInternal = TRUE)

con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
pagees <- readLines(con)
print(pagees)

close(con)


