library(ggplot2)
library(dplyr)
library(reshape2)

df=read.csv('G:\\My Drive\\Courses\\Fall 2022\\PLSCS 5290 Remote Sensing Sun\\FinalProject\\Xls\\AllParishCombinedLCClassProbability.csv')

lcprob <- df %>%
  group_by(Date, Parish) %>%
  summarise_all("mean")

# may not need to do this
plotData = melt(lcprob, id.vars=c("Parish"), value.name="value", variable.name="Date")
(headplotData)

lcPlot <- ggplot(data=lcprob, aes(x=Date, y=Bare, group=Parish, color=Parish)) +
  geom_line() + labs(y="Probability", x="Date") +
  ggtitle("Daily ") +
  theme(axis.text.x = element_text(angle=90, vjust=0.5, hjust=1))

lcPlot

# do cumulative of all parish data
lcprob_all <- df %>%
  group_by(Date) %>%
  summarise_all("mean")

lcprob_all <- subset(lcprob_all, select=-c(Parish))

lcprob_all <- na.omit(lcprob_all)

# rearrange to tall  format
lcprob_all_melt <- melt(lcprob_all, id.vars="Date")

# cast date to datetime format so we can order the x axis before plotting
lcprob_all_melt$Date <- as.POSIXct(lcprob_all_melt$Date, format="%d-%b-%y")
lcprob_all_melt<- lcprob_all_melt[order(lcprob_all_melt$Date),]

# Everything on the same plot
# ggplot(lcprob_all_melt, aes(Date,value, col=variable)) +
#   geom_point() +
#   stat_smooth()

lcPlot_all <- ggplot(data=lcprob_all_melt, aes(x=Date, y=value, group=variable, color=variable, fill=variable)) +
  # geom_point() + 
  geom_bar(stat="identity") +
  labs(y="Probability", x="Date") +
  ggtitle("Daily LC Cumulative Probability Percentages") +
  theme(axis.text.x = element_text(angle=90, vjust=0.5, hjust=1)) +
  scale_x_continuous(breaks = pretty(lcprob_all_melt$Date, n=5))

lcPlot_all