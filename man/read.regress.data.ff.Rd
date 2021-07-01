\name{read.regress.data.ff}
\alias{read.regress.data.ff}

\title{Read in Tabulated Data and Compute Summary Statistics}

\description{This function reads in tabulated data sets and produces summary statistics needed for Bayesian linear regression models for use in the function \code{bayes.regress()} (in this package). Big data sets that are too large to fit into R memory are handled using functions from package \code{ff}. The function takes as input data files with the predictor variables \eqn{X} and response values \eqn{Y}, and returns the summary statistics \eqn{X'X}, \eqn{X'Y} and \eqn{Y'Y} that are used as an input to the function \code{bayes.regress()} (in this package) for Bayesian linear regression models. The function supports reading data sets that are split across multiple files.}
\usage{
read.regress.data.ff(filename=NULL,predictor.cols=NA,response.col=NA,update.summaries=NULL
                   , fileEncoding = "", nrows = -1, first.rows = 1e5, next.rows = 1e5
                   , levels = NULL, appendLevels = TRUE,FUN = "read.table",transFUN = NULL
                   , asffdf_args = list(), BATCHBYTES = getOption("ffbatchbytes")
                   , VERBOSE = FALSE, header = FALSE, sep = ",", quote = "\"'", dec = "."
                   , numerals = c("allow.loss", "warn.loss", "no.loss")
                   , na.strings = "NA", colClasses = "numeric", skip = 0
                   , check.names = TRUE, fill = TRUE, strip.white = FALSE
                   , blank.lines.skip = TRUE, comment.char = "#", allowEscapes = FALSE
                   , flush = FALSE, skipNul = FALSE)
}

\arguments{
  \item{filename}{the name of a file or a list of file names, from which the data will be read. By default it is assumed that the file(s) contain data in comma separated format; this can be changed using the \code{sep} argument. File names must be in the format acceptable by standard functions such as \code{\link{read.table}}. Default = \code{NULL}.
}
 
  \item{predictor.cols}{a vector of integers that specifies the columns to treat as predictor variables, to create the design matrix \eqn{X}. By default, all columns after the first are treated as columns with predictor variables. Default = \code{NA}.}
  
  \item{response.col}{an integer that specifies the column that contains the response variable values, to create the response vector \eqn{Y}. By default, the first column that is not used as a predictor variable column is selected as the response values column. Default = \code{NA}.}
  
  \item{update.summaries}{The name of the R object containing previously-calculated summary statistics (if applicable), to be updated with new data. This must be a list similar in structure to the returned value, containing entries \code{xtx}, \code{xty}, \code{yty} and \code{numsamp.data} of appropriate dimensions and class that match the data contained in \code{filename}. Default = \code{NULL}.}
  The remaining arguments are passed directly to the function \code{\link{read.table.ffdf}()}. Below is a short description of the arguments we recommend to set manually in accordance with memory limitations and data structure:
  \item{first.rows}{the number of rows to read in the first chunk of data. Default = 100,000.}
  \item{next.rows}{the number of rows to read in the remaining chunks of data. Default = 100,000.}
  \item{sep}{the character that separates the columns of data. Default = ",".}
  For the arguments below the default settings should perform well. However, in some situations adjusting these arguments may improve memory use and running time.
  \item{fileEncoding}{a string that describes the file's character encoding}
  \item{nrows}{an integer specifying how many rows should be read from the file}
  \item{levels}{an optional list of items with \code{col.names} or factor columns. See \code{\link{read.table.ffdf}()}.}
  \item{appendLevels}{a logical vector of permission to expand \code{levels}}
  \item{FUN}{specifies which standard R function is used to read the data.}
  \item{transFUN}{an optional filtering function to be applied to each chunk of data. See \code{\link{read.table.ffdf}()}.}
  \item{asffdf_args}{an optional list of parameters to be passed to \code{\link{as.ffdf}()} function.}
  \item{BATCHBYTES}{an integer limiting the size of the \code{data.frame} used to store each chunk of the data}
  \item{VERBOSE}{See \code{\link{read.table.ffdf}()}.}
  \item{header}{a logical value indicating if the first row is the header row}
  \item{quote}{a character string specifying which character will be treated as quoting characters}
  \item{dec}{a character used for decimal dot}
  \item{numerals}{see \code{\link{read.table}()}.}
  \item{na.strings}{strings treated as \code{NA} values}
  \item{colClasses}{a vector that describes the data types in each column. Numeric by default.}
  \item{skip}{how many first lines in the file should be skipped}
  \item{check.names}{see \code{\link{read.table}()}.}
  \item{fill}{logical value that turns on automatic padding of the rows in case they have different lengths}
  \item{strip.white}{affects the processing of the columns with declared \code{character} type. See \code{\link{scan}()}.}
  \item{blank.lines.skip}{logical value, indicating whether empty lines should be ignored}
  \item{comment.char}{character specifying the comment marker}
  \item{allowEscapes}{logical. If \code{TRUE}, the escaped strings will be parsed. See \code{\link{scan}()}.}
  \item{flush}{see \code{\link{read.table}()}.}
  \item{skipNul}{logical: should nuls be skipped?}
}


\details{The function reads in data and computes summary statistics to be used in Bayesian linear regression by the function \code{bayes.regress()} (in this package). The function assumes the linear regression model will have a non-zero y-intercept; this option can be changed in the \code{bayes.regress()} function (see \code{bayes.regress()} help for details).  
}

\value{The returned value for the \code{read.regress.data.ff()} function is a list containing the summary statistics named \code{xtx} (for \eqn{X'X}), \code{xty} (for \eqn{X'Y}), \code{yty} (for \eqn{Y'Y}) and the total number of data values \code{numsamp.data}. The summary statistic \code{xtx} contains a square matrix obtained by computing a dot product of the predictor variables data \eqn{X} with itself; a leading column of 1's is added to \eqn{X} for the y-intercept term. \code{xty} contains the vector obtained by computing the dot product of the transposed predictor variables data \eqn{X} with response variable data \eqn{Y}; a leading column of 1's is added to \eqn{X} for the y-intercept term. \code{yty} contains the dot product of the response variable data \eqn{Y} with itself. \code{numsamp.data} is the number of data values read from the data file(s); this number may be smaller than the number of rows in the data file, since some of the rows with missing data may be skipped according to specified function arguments. The summary statistics \eqn{X'X}, \eqn{X'Y} and  \eqn{Y'Y} are summed over data chunks by the following, for \eqn{m = 1,...,M} chunks:
\deqn{X'X = sum_{m=1}^{M} (X'_{m})( X_{m})}
\deqn{X'Y = sum_{m=1}^{M} (X'_{m})( Y_{m})}
\deqn{Y'Y = sum_{m=1}^{M} (Y'_{m})( Y_{m})}

The returned values are used as input to the function \code{bayes.regress()} (in this package). Note that the matrix \code{X} is given a leading column of 1's by default, for the y-intercept term of the Bayesian linear regression model. This can be removed by specifying a model with zero intercept in the function \code{bayes.regress()} (see \code{bayes.regress()} help for details).}

\references{
Carlin, B.P. and Louis, T.A. (2009) \emph{Bayesian Methods for Data Analysis, 3rd ed.}, Boca Raton, FL: Chapman and Hall/CRC Press.

Gelman, A., Carlin, J.B., Stern, H.S., Dunson, D.B., Vehtari, A. and Rubin, D.B. (2013) \emph{Bayesian Data Analysis, 3rd ed.}, Boca Raton, FL: Chapman and Hall/CRC Press.

Adler, D., Glaser, C., Nenadic, O., Oehlschlagel, J. and Zucchini, W. (2013) ff: memory-efficient storage of large data on disk and fast access functions. R package: \url{https://CRAN.R-project.org/package=ff}. 

}

\examples{
# The package includes several example data files, illustrated here.

#########
# Example
#########
# The following command finds the location of the data file
# that includes 4 predictor variables and 20,000 simulated data values.

filename <- system.file('data/regressiondata.nz.all.csv.gz', package='BayesSummaryStatLM')

# The file is formatted so that the simulated response variable is in the
# first column, and columns 2 to 5 contain simulated predictor variables.
# The simulated coefficients are: beta <- c(0.76, -0.92, 0.64, 0.57, -1.65), 
# where the first value is the y-intercept term in the Bayesian linear 
# regression model.  The sigma-squared term, i.e. the variance of the normally 
# distributed error terms, is simulated as: sigmasq <- 0.25

## Next, read the data and compute the summary statistics using the
# "read.regress.data.ff()" function.  By default, the first column is assumed 
# to be the response variable, and the remaining columns are assumed to contain
# predictor variable values.  The function will check if the file exists and 
# can be read.

data.values <- read.regress.data.ff(filename)
data.values

}
\keyword{multilinear}
\keyword{regression}