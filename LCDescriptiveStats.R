library(ggplot2)
library(dplyr)
library(reshape2)

dfPixCounts=read.csv('G:\\My Drive\\Courses\\Fall 2022\\PLSCS 5290 Remote Sensing Sun\\FinalProject\\Xls\\AllParishLCPixelCountsBeforeAfter.csv')

#convert numeric value columns to numeric datatype
lBefore <- sapply(dfPixCounts$Px.Count.Before, as.numeric)
lAfter <-dfPixCounts$Px.Count.After
lAfter <- gsub(",", "", lAfter) 
lAfter <- sapply(lAfter, as.numeric)
shapiro.test(lBefore)
shapiro.test(lAfter)

hist(lBefore)
hist(lAfter)