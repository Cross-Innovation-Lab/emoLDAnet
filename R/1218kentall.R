# kendall tau batch file
library(parallel)

getwd()
setwd("D:/！Work/psychology/LDA/1213data")

dtf <- read.csv("forest_1.csv")
dtf <- dtf[-which(is.na(dtf[,2])=="TRUE"),]
#dtf <- dtf[,-which(is.na(dtf[1,])=="TRUE")]

k <- numeric()
c <- list()
n <- ncol(dtf)
for (i in 2:4) {
  for (j in 5:n) {
    k[j-4] <- pcaPP::cor.fk(dtf[,i], dtf[,j])
  }
  c[[i-1]] <- k
}

kendall <- as.data.frame(c)
names(kendall)<- c("Q_D", "Q_A", "Q_L")
n_k <- ncol(kendall)
kendall[,n_k+1] <- names(dtf[,-c(1:4)])

print(kendall)
write.csv(kendall, "forest_f1.csv")

best_pos <- c(which.max(kendall[,1]), which.max(kendall[,2]), which.max(kendall[,3]))
print(kendall[best_pos,ncol(kendall)])


