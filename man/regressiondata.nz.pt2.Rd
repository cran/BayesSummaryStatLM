\name{regressiondata.nz.pt2}
\alias{regressiondata.nz.pt2}
\docType{data}
\title{
Simulated data for Bayesian linear regression models, for use in package examples.
}
\description{
10,000 samples of simulated data. The response values \eqn{y_i} are simulated according to the following: \deqn{y_i = 0.76 - 0.92*x_{i1} + 0.64*x_{i2} + 0.57*x_{i3} - 1.65*x_{i4} + \epsilon_i. }
Here, each predictor variable is simulated from a Normal distribution with mean  = 0 and variance = 1.0, and each \eqn{\epsilon_i} is simulated from a Normal distribution with mean = 0 and variance = 0.25; the predictor variables are assumed to be independent.

This file is a copy of the last 10,000 entries from the file \code{regressiondata.nz.all}, for illustration in the package examples of using multiple files.
}
\usage{data("regressiondata.nz.pt1")}
\format{
A data frame with 10,000 observations for five variables: \eqn{y, x_1, x_2, x_3, x_4}
}
\keyword{datasets}
