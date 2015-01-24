#Project 1 R Script

set.seed(1234)
lambda <- 0.2
number_of_simulation <- 1000
size_of_sample <- 40

# Create the simluation
sim <- matrix(rexp(number_of_simulation*size_of_sample, rate=lambda), number_of_simulation, size_of_sample)

#now take an average of the simluations
row_avgs <- rowMeans(sim)




# plot the histogram of averages
hist(row_avgs, breaks=50, prob=TRUE,
     main="Distribution of averages, drawn from exp_r with lambda (rate) 0.2", xlab="")

# Now we will add the density
lines(density(row_avgs))


# plot the theoretical center of distribution
abline(v=1/lambda, col="red")

# plot theoretical density of the averages of samples
xfit <- seq(min(row_avgs), max(row_avgs), length=100)

yfit <- dnorm(xfit, mean=1/lambda, sd=(1/lambda/sqrt(size_of_sample)))

lines(xfit, yfit, pch=22, col="red", lty=2)
# Place legend on the screen
legend('topright', c("simulation", "theoretical"), lty=c(1,2), col=c("black", "red"))

qqnorm(row_avgs) 
qqline(row_avgs)

coverage <- sapply(lambda_values, function(lamb) {
    mu_h <- rowMeans(matrix(rexp(size_of_sample*number_of_simulation, rate=0.2),
                            number_of_simulation, size_of_sample))
    
    ul <- mu_h + qnorm(0.975) * sqrt(1/lambda**2/size_of_sample)
    
    ll <- mu_h - qnorm(0.975) * sqrt(1/lambda**2/size_of_sample)
    
    mean(ll < lamb & ul > lamb)
})

library(ggplot2)
qplot(lambda_values, coverage) + geom_hline(yintercept=0.95)