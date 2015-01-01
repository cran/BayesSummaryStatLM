\name{regressiondata.nz.all}
\alias{regressiondata.nz.all}
\docType{data}
\title{
Simulated data for Bayesian linear regression models, for use in package examples.
}
\description{
20,000 samples of simulated data. The response values \eqn{y_i} are simulated according to the following: \deqn{y_i = 0.76 - 0.92*x_{i1} + 0.64*x_{i2} + 0.57*x_{i3} - 1.65*x_{i4} + \epsilon_i. }
Here, each predictor variable is simulated from a Normal distribution with mean  = 0 and variance = 1.0, and each \eqn{\epsilon_i} is simulated from a Normal distribution with mean = 0 and variance = 0.25; the predictor variables are assumed to be independent.
}
\usage{data("regressiondata.nz.all")}
\format{
A data frame with 20,000 observations for five variables: \eqn{y, x_1, x_2, x_3, x_4}
}
\keyword{datasets}
